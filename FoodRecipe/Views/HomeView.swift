//
//  MainView.swift
//  FoodRecipe
//
//  Created by Raul Palade on 15/05/24.
//

import SwiftUI

struct HomeView: View {
    @Binding var path: [HomeNavigation]
    @ObservedObject var authViewModel = AuthViewModel()

    var body: some View {
        NavigationStack(path: $path) {
            NavigationLink(value: HomeNavigation.recipeDetail) {
                Text("Recipe 1")
            }
            .navigationDestination(for: HomeNavigation.self) { screen in
                switch screen {
                    case .recipeDetail: RecipeDetailView()
                }
            }
        }
    }
}

#Preview {
    HomeView(path: .constant([HomeNavigation]()))
}
