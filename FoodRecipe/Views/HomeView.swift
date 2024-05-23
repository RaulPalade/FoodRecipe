//
//  MainView.swift
//  FoodRecipe
//
//  Created by Raul Palade on 15/05/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var chipViewModel = ChipViewModel()
    @EnvironmentObject var recipeViewModel: RecipeViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // MARK: Featured Section

                    VStack(alignment: .leading, content: {
                        SectionHeader(title: "Recipe of the day")
                        FeaturedCard(recipe: recipeViewModel.recipes[0])

                    }).padding(.top, 24)

                    // MARK: Popular Recipes

                    VStack(alignment: .leading, content: {
                        SectionHeader(title: "Popular Recipes")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(chipViewModel.chipArray) { chip in
                                    ChipButton(
                                        titleKey: chip.titleKey,
                                        isSelected: Binding<Bool>(
                                            get: { chipViewModel.isChipSelected(chip) },
                                            set: { isSelected in
                                                chipViewModel.selectChip(chip)
                                                if isSelected {
                                                    recipeViewModel.filterRecipes(by: chip.titleKey)
                                                } else {
                                                    recipeViewModel.filterRecipes(by: nil)
                                                }
                                            }
                                        ))
                                }
                            }
                        }
                        .padding(.bottom, 8)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(recipeViewModel.filteredRecipes) { recipe in
                                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                        PopularRecipeCard(
                                            recipe: recipe,
                                            favourite: authViewModel.currentUser?.favouriteRecipes.contains(recipe.id) ?? false,
                                            action: { addRecipeToFavourite(recipeId: recipe.id) }
                                        )
                                    }
                                }
                            }.padding()
                        }.scrollClipDisabled()
                    })
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
                .environmentObject(recipeViewModel)
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        VStack(alignment: .leading, content: {
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: "sun.max")
                                        .symbolRenderingMode(.palette)
                                        .foregroundStyle(Color("PrimaryLightColor"), .primary)
                                    Text("Good Morning")
                                        .font(.custom("Cabin-Regular", size: 14))
                                        .foregroundColor(Color("PrimaryDarkColor"))
                                        .multilineTextAlignment(.center)
                                }
                                if let user = authViewModel.currentUser {
                                    Text(user.name)
                                        .font(.custom("Cabin-Regular", size: 24))
                                        .foregroundColor(Color("PrimaryDarkColor"))
                                        .multilineTextAlignment(.center)
                                        .bold()
                                } else {
                                    Text("user.name")
                                        .font(.custom("Cabin-Regular", size: 24))
                                        .foregroundColor(Color("PrimaryDarkColor"))
                                        .multilineTextAlignment(.center)
                                        .bold()
                                }
                            }
                        })
                    }
                }
            }
        }
    }

    func addRecipeToFavourite(recipeId: String) {
        print("Recipe id:", recipeId)
    }
}

#Preview {
    HomeView()
}
