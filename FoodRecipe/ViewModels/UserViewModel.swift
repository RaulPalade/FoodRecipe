//
//  UserViewModel.swift
//  FoodRecipe
//
//  Created by Raul Palade on 22/05/24.
//

import Combine
import Firebase
import FirebaseFirestore
import Foundation

class UserViewModel: ObservableObject {
    let db: Firestore
    let usersRef: CollectionReference

    @Published var users: [AppUser] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = true

    private var cancellables = Set<AnyCancellable>()

    init() {
        db = Firestore.firestore()
        usersRef = db.collection("users")
        fetchUsers()
    }

    func fetchUsers() {
        let queryPublisher = Future<[AppUser], Error> {
            promise in
            Task {
                do {
                    let users = try await self.getUsers()
                    promise(.success(users))
                } catch {
                    promise(.failure(error))
                }
            }
        }.receive(on: DispatchQueue.main)

        queryPublisher
            .sink { completion in
                switch completion {
                case let .failure(error):
                    self.errorMessage = "Error getting documents: \(error.localizedDescription)"
                case .finished:
                    break
                }
            } receiveValue: { users in
                self.users = users
                print("USERS LOADING = FALSE")
                print(users)
                self.isLoading = false
            }
            .store(in: &cancellables)
    }

    func getUsers() async throws -> [AppUser] {
        var fetchedUsers: [AppUser] = []

        do {
            let querySnapshot = try await usersRef.getDocuments()

            for document in querySnapshot.documents {
                let documentId = document.documentID
                let data = document.data()

                if let name = data["name"] as? String,
                   let email = data["email"] as? String,
                   let about = data["about"] as? String,
                   let country = data["country"] as? [String: String],
                   let imageUrl = data["imageUrl"] as? String,
                   let favouriteRecipes = data["favouriteRecipes"] as? [String] {
                    let user = AppUser(
                        id: documentId,
                        name: name,
                        email: email,
                        about: about,
                        imageUrl: imageUrl,
                        favouriteRecipes: favouriteRecipes,
                        country: country
                    )

                    fetchedUsers.append(user)
                } else {
                    print("Error: Missing required fields in document data.")
                }
            }

        } catch let error as NSError {
            switch error.code {
            case FirestoreErrorCode.notFound.rawValue:
                print("Error: Collection not found")
            case FirestoreErrorCode.permissionDenied.rawValue:
                print("Error: Permission denied")
            default:
                print("Error fetching documents: \(error.localizedDescription)")
            }
            throw error
        } catch {
            print("Unexpected error: \(error.localizedDescription)")
            throw error
        }

        return fetchedUsers
    }
}
