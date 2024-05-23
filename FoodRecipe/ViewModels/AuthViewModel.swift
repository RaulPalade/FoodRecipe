//
//  AuthenticationService.swift
//  FoodRecipe
//
//  Created by Raul Palade on 15/05/24.
//

import Combine
import FirebaseAuth
import FirebaseFirestore

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
            .removeDuplicates()
            .sink { [weak self] authState in
                guard let self = self else { return }
                if authState == .signedOut {
                    print("User not authenticated")
                    self.currentUser = nil
                    self.isLoading = false
                } else if authState == .signedIn {
                    print("User authenticated")
                    self.fetchCurrentUser()
                }
            }
            .store(in: &cancellables)
    }

    func checkAuthStatus() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            self.isLoading = false
            self.authState = user != nil ? .signedIn : .signedOut
            self.loggedUserEmail = user?.email ?? ""
            if user != nil {
                self.fetchCurrentUser()
            }
        }
    }

    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            guard let self = self else { return }
            if let error = error {
                print("Error on login:", error.localizedDescription)
                self.loginError = error
                return
            }
            self.authState = .signedIn
            self.loggedUserEmail = email
            self.fetchCurrentUser() // Fetch user data immediately after login
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
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            guard let self = self else { return }
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
        guard !loggedUserEmail.isEmpty else {
            print("Logged user email is empty, skipping fetchCurrentUser")
            return
        }
        let queryPublisher = Future<AppUser, Error> { [weak self] promise in
            guard let self = self else { return }
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
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case let .failure(error):
                    self.errorMessage = "Error getting currentUser \(error.localizedDescription)"
                case .finished:
                    break
                }
            } receiveValue: { [weak self] user in
                guard let self = self else { return }
                self.currentUser = user
            }.store(in: &cancellables)
    }

    func getCurrentUser() async throws -> AppUser {
        do {
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
