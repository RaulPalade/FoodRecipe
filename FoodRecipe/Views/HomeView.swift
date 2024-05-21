//
//  MainView.swift
//  FoodRecipe
//
//  Created by Raul Palade on 15/05/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var authViewModel = AuthViewModel()
    @StateObject private var viewModel = ChipViewModel()
    @StateObject private var recipeViewModel = RecipeViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // MARK: Featured Section

                    VStack(alignment: .leading, content: {
                        SectionHeader(title: "Recipe of the day")
                        FeaturedCard(title: "Asian white noodle with extra seafood", authorName: "James Spader", time: "20 min")

                    })

                    // MARK: Popular Recipes

                    VStack(alignment: .leading, content: {
                        SectionHeader(title: "Popular Recipes")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(viewModel.chipArray) { chip in
                                    ChipButton(titleKey: chip.titleKey, isSelected: chip.isSelected)
                                }
                            }
                        }
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
                                        .foregroundStyle(Color("AppPrimaryColor"), .primary)
                                    Text("Good Morning")
                                        .font(.custom("Cabin-Regular", size: 14))
                                        .foregroundColor(Color("ButtonColor"))
                                        .multilineTextAlignment(.center)
                                }
                                if let user = authViewModel.currentUser {
                                    Text(user.email ?? "")
                                        .font(.custom("Cabin-Regular", size: 24))
                                        .foregroundColor(Color("ButtonColor"))
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
}

#Preview {
    HomeView()
}
