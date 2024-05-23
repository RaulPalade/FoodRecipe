//
//  FoodRecipeApp.swift
//  FoodRecipe
//
//  Created by Raul Palade on 14/05/24.
//

import Firebase
import FirebaseCore
import FirebaseFirestore
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct FoodRecipeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var recipeViewModel = RecipeViewModel()
    //@StateObject var userViewModel = UserViewModel()
    @AppStorage("isOnboarding") var isOnboarding: Bool = true

    var body: some Scene {
        WindowGroup {
            if !authViewModel.isLoading && !recipeViewModel.isLoading {
                if isOnboarding {
                    OnboardingView()
                } else if authViewModel.authState == .signedOut {
                    LoginView().environmentObject(authViewModel)
                } else {
                    TabScreenView()
                        .environmentObject(authViewModel)
                        .environmentObject(recipeViewModel)
                }
            }
        }
    }
}
