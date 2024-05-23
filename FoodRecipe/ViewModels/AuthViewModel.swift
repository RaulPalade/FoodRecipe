//
//  AuthenticationService.swift
//  FoodRecipe
//
//  Created by Raul Palade on 15/05/24.
//

import Combine
import Firebase
import FirebaseAuth

class AuthViewModel: ObservableObject {
    enum AuthState {
        case signedIn
        case signedOut
    }

    let db: Firestore
    let usersRef: CollectionReference

    @Published var currentUser: AppUser? = nil
    @Published var authState: AuthState = .signedOut
    @Published var loginError: Error? = nil
    @Published var resetPasswordError: Error? = nil
    @Published var resetPasswordSuccess: Bool = false
    @Published var isLoading: Bool = true
    @Published var errorMessage: String? = nil
    var loggedUserEmail: String = ""
    private var cancellables = Set<AnyCancellable>()

    init() {
        db = Firestore.firestore()
        usersRef = db.collection("users")
        checkAuthStatus()
        
        $authState
            .sink { authState in
                if authState == .signedOut {
                    print("User not authenticated ")
                } else if authState == .signedIn {
                    print("User authenticated")
                    self.fetchCurrentUser()
                }
            }
            .store(in: &cancellables)
    }

    func checkAuthStatus() {
        Auth.auth().addStateDidChangeListener { _, user in
            self.isLoading = false
            self.authState = user != nil ? .signedIn : .signedOut
            self.loggedUserEmail = user?.email ?? ""
        }
    }

    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                print("Error on login:", error.localizedDescription)
                self.loginError = error
                return
            }
            self.authState = .signedIn
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            authState = .signedOut
        } catch {
            print("Error on logout:", error.localizedDescription)
        }
    }

    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Error on password reset", error.localizedDescription)
                self.resetPasswordError = error
                self.resetPasswordSuccess = false
                return
            }
            self.resetPasswordSuccess = true
        }
    }

    func fetchCurrentUser() {
        let queryPublisher = Future<AppUser, Error> { promise in
            Task {
                do {
                    let user = try await self.getCurrentUser()
                    promise(.success(user))
                } catch {
                    promise(.failure(error))
                }
            }

        }.receive(on: DispatchQueue.main)

        queryPublisher
            .sink { completion in
                switch completion {
                case let .failure(error):
                    self.errorMessage = "Error getting currentUser \(error.localizedDescription)"
                case .finished:
                    break
                }
            } receiveValue: { user in
                self.currentUser = user
            }.store(in: &cancellables)
    }

    func getCurrentUser() async throws -> AppUser {
        do {
            print("LoggedUserEmail:", loggedUserEmail)
            let querySnapshot = try await usersRef.whereField("email", isEqualTo: loggedUserEmail).getDocuments()

            if let document = querySnapshot.documents.first {
                let data = document.data()
                let documentId = document.documentID

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
                    print(user)
                    return user
                } else {
                    throw NSError(domain: "getCurrentUser", code: 1, userInfo: [NSLocalizedDescriptionKey: "Missing required fields in document data for document ID \(documentId)."])
                }
            } else {
                throw NSError(domain: "getCurrentUser", code: 2, userInfo: [NSLocalizedDescriptionKey: "No document found with the provided email."])
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
    }
}
