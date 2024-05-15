//
//  ContentView.swift
//  FoodRecipe
//
//  Created by Raul Palade on 14/05/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authViewModel = AuthViewModel()

    var body: some View {
        Group {
            if authViewModel.authState == .signedIn {
                MainView()
            } else {
                NavigationView {
                    LoginView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
