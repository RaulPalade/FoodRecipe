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

    @Published var currentUser: User? = nil
    @Published var authState: AuthState = .signedOut
    @Published var loginError: Error? = nil
    @Published var resetPasswordError: Error? = nil
    @Published var resetPasswordSuccess: Bool = false
    @Published var isLoading: Bool = true
    private var cancellables = Set<AnyCancellable>()

    init() {
        checkAuthStatus()

        $authState
            .sink { authState in
                if authState == .signedOut {
                    print("User not authenticated ")
                } else if authState == .signedIn {
                    print("User authenticated")
                }
            }
            .store(in: &cancellables)
    }

    func checkAuthStatus() {
        Auth.auth().addStateDidChangeListener { _, user in
            self.isLoading = false
            self.authState = user != nil ? .signedIn : .signedOut
            self.currentUser = user
        }
    }

    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error on login:", error.localizedDescription)
                self.loginError = error
                return
            }
            self.authState = .signedIn
            self.currentUser = authResult?.user
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
}
