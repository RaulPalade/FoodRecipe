//
//  FoodRecipeApp.swift
//  FoodRecipe
//
//  Created by Raul Palade on 14/05/24.
//

import FirebaseCore
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
    @AppStorage("isOnboarding") var isOnboarding: Bool = true

    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnboardingView()
            } else {
                MainView()
            }
        }
    }
}
