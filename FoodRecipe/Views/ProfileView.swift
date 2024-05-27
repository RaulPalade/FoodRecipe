//
//  ProfileView.swift
//  FoodRecipe
//
//  Created by Raul Palade on 20/05/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var recipeViewModel: RecipeViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    authorCard

                    Text("My favourites")
                        .font(.custom("Cabin-Regular", size: 20))
                        .foregroundColor(Color("PrimaryDarkColor"))
                        .bold()
                        .multilineTextAlignment(.leading)

                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible(), spacing: 16),
                    ], spacing: 16) {
                        ForEach(recipeViewModel.myFavRecipes.indices, id: \.self) { index in
                            let recipe = recipeViewModel.myFavRecipes[index]
                            NavigationLink(destination: RecipeDetailView(recipe: recipe, 
                                                                         isFavourite: authViewModel.currentUser?.favouriteRecipes.contains(recipe.id) ?? false)) {
                                MyFavCard(recipe: recipe, favourite: true, setFavourite: {})
                            }
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Text("Account")
                        .font(.custom("Cabin-Regular", size: 24))
                        .foregroundColor(Color("PrimaryDarkColor"))
                        .multilineTextAlignment(.center)
                        .bold()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: logout) {
                        Text("Logout")
                            .font(.custom("Cabin-Regular", size: 18))
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color("PrimaryDarkColor"))
                    .foregroundColor(.white)
                }
            }
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }

    func signOut() {
        authViewModel.logout()
    }

    func logout() {
    }

    private var authorCard: some View {
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
                Text(authViewModel.currentUser?.name ?? "")
                    .font(.custom("Cabin-Regular", size: 20))
                    .foregroundColor(Color("PrimaryDarkColor"))
                    .bold()
                Text(authViewModel.currentUser?.about ?? "")
                    .font(.custom("Cabin-Regular", size: 16))
                    .foregroundColor(Color("PrimaryDarkColor"))
                    .lineLimit(1)

            })
        })
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 0)
    }
}

#Preview {
    ProfileView()
}
