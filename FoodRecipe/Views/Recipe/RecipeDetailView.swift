//
//  RecipeDetailView.swift
//  FoodRecipe
//
//  Created by Raul Palade on 20/05/24.
//

import ScalingHeaderScrollView
import SwiftUI

enum TabMenu: String, CaseIterable, Identifiable {
    case ingredients = "Ingredients"
    case instructions = "Instructions"
    var id: TabMenu { self }
}

struct RecipeDetailView: View {
    var recipe: Recipe
    var avatarImage: String = "foodBgPortrait"

    @Environment(\.presentationMode) var presentationMode
    @State var progress: CGFloat = 0
    private let minHeight = 110.0
    private let maxHeight = 372.0

    @State private var selectedTab: TabMenu = .ingredients

    var body: some View {
        ZStack {
            ScalingHeaderScrollView {
                ZStack {
                    Color.white.edgesIgnoringSafeArea(.all)
                    largeHeader(progress: progress)
                }
            } content: {
                profilerContentView
            }
            .height(min: minHeight, max: maxHeight)
            .collapseProgress($progress)
            .allowsHeaderGrowth()

            topButtons
        }
        .ignoresSafeArea()
    }

    private var topButtons: some View {
        VStack {
            HStack {
                Button("", action: { self.presentationMode.wrappedValue.dismiss() })
                    .buttonStyle(CircleButtonStyle(imageName: "arrow.backward"))
                    .padding(.leading, 17)
                    .padding(.top, 50)
                Spacer()
                Button("", action: { print("Info") })
                    .buttonStyle(CircleButtonStyle(imageName: "ellipsis"))
                    .padding(.trailing, 17)
                    .padding(.top, 50)
            }
            Spacer()
        }
        .ignoresSafeArea()
    }

    // SERVE
    private var smallHeader: some View {
        HStack(spacing: 12.0) {
            Image(avatarImage)
                .resizable()
                .frame(width: 40.0, height: 40.0)
                .clipShape(RoundedRectangle(cornerRadius: 6.0))

            Text(recipe.name)
                .fontRegular(color: .appDarkGray, size: 17)
        }
    }

    // SERVE
    private func largeHeader(progress: CGFloat) -> some View {
        ZStack {
            Image(avatarImage)
                .resizable()
                .scaledToFill()
                .frame(height: maxHeight)
                .opacity(1 - progress)

            VStack {
                Spacer()

                HStack(spacing: 4.0) {
                    Capsule()
                        .frame(width: 40.0, height: 3.0)
                        .foregroundColor(.white)

                    Capsule()
                        .frame(width: 40.0, height: 3.0)
                        .foregroundColor(.white.opacity(0.2))

                    Capsule()
                        .frame(width: 40.0, height: 3.0)
                        .foregroundColor(.white.opacity(0.2))
                }

                ZStack(alignment: .leading) {
                    VisualEffectView(effect: UIBlurEffect(style: .regular))
                        .mask(Rectangle().cornerRadius(40, corners: [.topLeft, .topRight]))
                        .offset(y: 10.0)
                        .frame(height: 80.0)

                    RoundedRectangle(cornerRadius: 40.0, style: .circular)
                        .foregroundColor(.clear)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.white.opacity(0.0), .white]), startPoint: .top, endPoint: .bottom)
                        )

                    userNameComponent
                        .padding(.leading, 24.0)
                        .padding(.top, 10.0)
                        .opacity(1 - max(0, min(1, (progress - 0.75) * 4.0)))

                    smallHeader
                        .padding(.leading, 85.0)
                        .opacity(progress)
                        .opacity(max(0, min(1, (progress - 0.75) * 4.0)))
                }
                .frame(height: 80.0)
            }
        }
    }

    private var profilerContentView: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    description

                    HStack(content: {
                        nutritionElement2(icon: "carbs", title: recipe.nutrition.carb, unit: "carbs")
                        Spacer()
                        nutritionElement2(icon: "proteins", title: recipe.nutrition.proteins, unit: "proteins")
                    })

                    HStack(content: {
                        nutritionElement2(icon: "calories", title: recipe.nutrition.carb, unit: "Kcals")
                        Spacer()
                        nutritionElement2(icon: "fats", title: recipe.nutrition.proteins, unit: "fats")
                    })

                    Picker("Tab Selector", selection: $selectedTab) {
                        ForEach(TabMenu.allCases) { tab in
                            Text(tab.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)

                    ForEach(recipe.ingredients) { ingredient in
                        ingredientCard(image: ingredient.imageUrl, title: ingredient.name, quantity: ingredient.quantity)
                        ingredientCard(image: ingredient.imageUrl, title: ingredient.name, quantity: ingredient.quantity)
                        ingredientCard(image: ingredient.imageUrl, title: ingredient.name, quantity: ingredient.quantity)
                    }

                    authorSection()
                    otherRecipesOfAuthor()
                    
                    Color.clear.frame(height: 100)
                }
                .padding(.horizontal, 24)
            }
        }
    }

    private var userNameComponent: some View {
        HStack(content: {
            Text(recipe.name)
            Spacer()
            Image(systemName: "clock")
            Text(recipe.time)
        })
    }

    private func nutritionElement2(icon: String, title: Double, unit: String) -> some View {
        HStack(content: {
            Image(icon)
                .padding()
                .background(Color("AppLabelColor"))
                .cornerRadius(8)
            Text(String(title) + " " + unit)
        })
    }

    private func ingredientCard(image: String, title: String, quantity: String) -> some View {
        HStack(content: {
            Image(image)
                .padding()
                .background(Color("AppLabelColor"))
                .cornerRadius(8)
            Text(title)
            Spacer()
            Text(quantity)
        })
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.primary.opacity(0.1), radius: 10, x: 0, y: 0)
    }

    private func authorSection() -> some View {
        VStack(alignment: .leading, content: {
            Text("Creator")
                .font(.custom("Cabin-Regular", size: 20))
                .foregroundColor(Color("PrimaryDarkColor"))
                .bold()
            HStack(content: {
                Image("profilePic")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 2)
                    )

                VStack(alignment: .leading, content: {
                    Text("Natalia Luca")
                        .font(.custom("Cabin-Regular", size: 16))
                        .foregroundColor(Color("PrimaryDarkColor"))
                    Text("I'm the author and recipe developer.")
                        .font(.custom("Cabin-Regular", size: 16))
                        .foregroundColor(Color("PrimaryDarkColor"))
                })
            })
        })
    }
    
    private func otherRecipesOfAuthor() -> some View {
        VStack(alignment: .leading, content: {
            Text("Related Recipes")
                .font(.custom("Cabin-Regular", size: 20))
                .foregroundColor(Color("PrimaryDarkColor"))
                .bold()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    authorRecipesCard()
                    authorRecipesCard()
                    authorRecipesCard()
                    /*ForEach(recipeViewModel.filteredRecipes) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            PopularRecipeCard(
                                recipe: recipe,
                                favourite: authViewModel.currentUser?.favouriteRecipes.contains(recipe.id) ?? false,
                                action: { addRecipeToFavourite(recipeId: recipe.id) }
                            )
                        }
                    }*/
                }.padding()
            }.scrollClipDisabled()
        })
    }
    
    private func authorRecipesCard() -> some View {
        VStack {
            ZStack {
                Image("foodCardBg")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 12)
                    .frame(maxWidth: .infinity)
            }

            Text(recipe.name)
                .font(.custom("Cabin-Regular", size: 16))
                .foregroundColor(Color("PrimaryDarkColor"))
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)

            HStack(content: {
                Image(systemName: "flame")
                    .font(.custom("Cabin-Regular", size: 14))
                    .foregroundColor(Color("GrayTextColor"))
                Text(String(recipe.nutrition.calories) + " cal")
                    .font(.custom("Cabin-Regular", size: 14))
                    .foregroundColor(Color("GrayTextColor"))
                Image(systemName: "circle.fill")
                    .font(.custom("Cabin-Regular", size: 8))
                    .foregroundColor(Color("GrayTextColor"))
                Image(systemName: "clock")
                    .font(.custom("Cabin-Regular", size: 14))
                    .foregroundColor(Color("GrayTextColor"))
                Text(recipe.time)
                    .font(.custom("Cabin-Regular", size: 14))
                    .foregroundColor(Color("GrayTextColor"))
            })
            .padding(.top, 4)
            .padding(.bottom, 12)
        }
        .frame(width: UIScreen.main.bounds.width / 1.7)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 0)
    }

    private var description: some View {
        Text(recipe.description)
    }
}

#Preview {
    RecipeDetailView(recipe: recipePreviewData)
}
