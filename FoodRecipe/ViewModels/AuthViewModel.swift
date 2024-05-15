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

    @Published var authState: AuthState = .signedOut
    @Published var loginError: Error? = nil
    private var cancellables = Set<AnyCancellable>()

    init() {
        Auth.auth().addStateDidChangeListener { _, user in
            self.authState = user != nil ? .signedIn : .signedOut
        }

        $authState
            .sink { authState in
                if authState == .signedOut {
                    print("Utente non loggato")
                }
            }
            .store(in: &cancellables)
    }

    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                print("Errore durante il login:", error.localizedDescription)
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
            print("Errore durante il logout:", error.localizedDescription)
        }
    }
}
