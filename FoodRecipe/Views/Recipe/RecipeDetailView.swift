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
    var isFavourite: Bool
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
                .padding(.horizontal, 24)
                .padding(.top, 40)
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }

    private var topButtons: some View {
        VStack {
            HStack {
                Button("", action: { self.presentationMode.wrappedValue.dismiss() })
                    .buttonStyle(SquareButtonStyle(imageName: "arrow.backward"))
                Spacer()

                isFavourite ? Button("", action: { print("Info") })
                    .buttonStyle(SquareButtonStyle(imageName: "heart.fill")) :
                    Button("", action: { print("Info") })
                    .buttonStyle(SquareButtonStyle(imageName: "heart"))
            }
            Spacer()
        }
    }

    private var smallHeader: some View {
        HStack(spacing: 12) {
            Image(avatarImage)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 6))

            Text(recipe.name)
                .fontRegular(color: .gray, size: 17)
        }
    }

    private func largeHeader(progress: CGFloat) -> some View {
        ZStack {
            Image(avatarImage)
                .resizable()
                .scaledToFill()
                .frame(height: maxHeight)
                .opacity(1 - progress)

            VStack {
                Spacer()

                HStack(spacing: 4) {
                    Capsule()
                        .frame(width: 40, height: 3)
                        .foregroundColor(.white)

                    Capsule()
                        .frame(width: 40, height: 3)
                        .foregroundColor(.white.opacity(0.2))

                    Capsule()
                        .frame(width: 40, height: 3)
                        .foregroundColor(.white.opacity(0.2))
                }

                ZStack(alignment: .leading) {
                    VisualEffectView(effect: UIBlurEffect(style: .regular))
                        .mask(Rectangle().cornerRadius(40, corners: [.topLeft, .topRight]))
                        .offset(y: 10)
                        .frame(height: 80)

                    RoundedRectangle(cornerRadius: 40, style: .circular)
                        .foregroundColor(.clear)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.white.opacity(0), .white]), startPoint: .top, endPoint: .bottom)
                        )

                    recipeNameComponent
                        .padding(.leading, 24)
                        .padding(.trailing, 24)
                        .padding(.top, 10)
                        .opacity(1 - max(0, min(1, (progress - 0.75) * 4.0)))

                    smallHeader
                        .padding(.leading, 85)
                        .opacity(progress)
                        .opacity(max(0, min(1, (progress - 0.75) * 4.0)))
                }
                .frame(height: 80)
            }
        }
    }

    private var profilerContentView: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    description

                    HStack(content: {
                        nutritionItem(icon: "carbs", title: recipe.nutrition.carb, unit: "carbs")
                        Spacer()
                        nutritionItem(icon: "proteins", title: recipe.nutrition.proteins, unit: "proteins")
                    })

                    HStack(content: {
                        nutritionItem(icon: "calories", title: recipe.nutrition.carb, unit: "Kcals")
                        Spacer()
                        nutritionItem(icon: "fats", title: recipe.nutrition.proteins, unit: "fats")
                    })

                    HStack(content: {
                        ForEach(TabMenu.allCases) { tab in
                            Text(tab.rawValue)
                                .font(.custom("Cabin-Regular", size: 16))
                                .bold()
                                .padding(10)
                                .frame(maxWidth: .infinity)
                                .background(self.selectedTab == tab ? Color("PrimaryDarkColor") : Color.clear)
                                .foregroundColor(self.selectedTab == tab ? Color.white : Color("PrimaryDarkColor"))
                                .cornerRadius(self.selectedTab == tab ? 16 : 0)
                                .onTapGesture {
                                    withAnimation {
                                        self.selectedTab = tab
                                    }
                                }
                        }
                    })
                    .padding(4)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(16)

                    ForEach(recipe.ingredients) { ingredient in
                        ingredientCard(image: ingredient.imageUrl, title: ingredient.name, quantity: ingredient.quantity)
                    }

                    creatorSection()
                    otherRecipesOfAuthor()

                    Color.clear.frame(height: 100)
                }
                .padding(.horizontal, 24)
            }
        }
    }

    private var recipeNameComponent: some View {
        HStack(content: {
            Text(recipe.name)
                .font(.custom("Cabin-Regular", size: 24))
                .foregroundColor(Color("PrimaryDarkColor"))
                .bold()
            Spacer()
            Image(systemName: "clock")
                .font(.custom("Cabin-Regular", size: 14))
                .foregroundColor(Color("PrimaryDarkColor"))
            Text(recipe.time)
                .font(.custom("Cabin-Regular", size: 14))
                .foregroundColor(Color("PrimaryDarkColor"))
        })
    }

    private var description: some View {
        Text(recipe.description)
            .font(.custom("Cabin-Regular", size: 16))
            .foregroundColor(Color("PrimaryDarkColor"))
    }

    private func nutritionItem(icon: String, title: Double, unit: String) -> some View {
        HStack(content: {
            Image(icon)
                .padding()
                .background(Color("AppLabelColor"))
                .cornerRadius(8)
            Text(String(title) + " " + unit)
                .font(.custom("Cabin-Regular", size: 16))
                .foregroundColor(Color("PrimaryDarkColor"))
        }).frame(maxWidth: .infinity, alignment: .leading)
    }

    private func ingredientCard(image: String, title: String, quantity: String) -> some View {
        HStack(content: {
            Image("foodForCard")
                .resizable()
                .frame(width: 30, height: 30)
                .padding(.all, 8)
                .background(Color("AppLabelColor"))
                .cornerRadius(8)
            Text(title)
                .font(.custom("Cabin-Regular", size: 18))
                .bold()
                .padding(.leading, 8)
            Spacer()
            Text(quantity)
                .font(.custom("Cabin-Regular", size: 18))
                .bold()
        })
        .padding(.all)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.primary.opacity(0.1), radius: 10, x: 0, y: 0)
    }

    private func creatorSection() -> some View {
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
            HStack(content: {
                Text("Related Recipes")
                    .font(.custom("Cabin-Regular", size: 20))
                    .foregroundColor(Color("PrimaryDarkColor"))
                    .bold()
                Spacer()

                NavigationLink(destination: AllRecipesView()) {
                    Text("See All")
                        .font(.custom("Cabin-Regular", size: 20))
                        .foregroundColor(Color("PrimaryLightColor"))
                        .bold()
                }

            })

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    authorRecipesCard()
                    authorRecipesCard()
                    authorRecipesCard()
                    /* ForEach(recipeViewModel.filteredRecipes) { recipe in
                         NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                             PopularRecipeCard(
                                 recipe: recipe,
                                 favourite: authViewModel.currentUser?.favouriteRecipes.contains(recipe.id) ?? false,
                                 action: { addRecipeToFavourite(recipeId: recipe.id) }
                             )
                         }
                     } */
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
                    .padding(.all, 8)
                    .frame(maxWidth: .infinity)
            }

            Text(recipe.name)
                .font(.custom("Cabin-Regular", size: 16))
                .foregroundColor(Color("PrimaryDarkColor"))
                .bold()
                .frame(alignment: .center)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .truncationMode(.tail)
                .padding([.leading, .trailing], 8)
                .padding(.bottom, 12)
        }
        .frame(width: UIScreen.main.bounds.width / 3)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 0)
    }
}

#Preview {
    RecipeDetailView(recipe: recipePreviewData, isFavourite: true)
}
