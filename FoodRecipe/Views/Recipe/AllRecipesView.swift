//
//  AllRecipesView.swift
//  FoodRecipe
//
//  Created by Raul Palade on 24/05/24.
//

import SwiftUI

struct AllRecipesView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var recipeViewModel: RecipeViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16, content: {
                    ForEach(recipeViewModel.recipes.indices, id: \.self) { index in
                        let recipe = recipeViewModel.recipes[index]
                        AllRecipesItem(recipe: recipe)
                    }
                })
            }
            .padding()
            .scrollClipDisabled()
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
}

#Preview {
    AllRecipesView()
}
