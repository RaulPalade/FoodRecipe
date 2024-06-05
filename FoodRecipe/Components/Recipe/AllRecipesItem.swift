//
//  AllRecipesItem.swift
//  FoodRecipe
//
//  Created by Raul Palade on 29/05/24.
//

import SwiftUI

struct AllRecipesItem: View {
    var recipe: RecipeViewData
    
    var body: some View {
        HStack(content: {
            Image(uiImage: recipe.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(16)
                .padding(.all, 8)
                .frame(width: UIScreen.main.bounds.width / 3)
            VStack(alignment: .leading, content: {
                Text(recipe.name)
                    .font(.custom("Cabin-Regular", size: 16))
                    .foregroundColor(Color("PrimaryDarkColor"))
                    .bold()
                HStack(content: {
                    Image(uiImage: recipe.author.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 2)
                        )

                    Text(recipe.author.name)
                        .font(.custom("Cabin-Regular", size: 14))
                        .foregroundColor(Color("GrayTextColor"))
                })
            })
            .padding(.trailing, 16)
            Spacer()

            NavigationLink(destination: RecipeDetailView(recipe: recipePreviewData, isFavourite: true)) {
                Button("", action: { })
                    .buttonStyle(SquareButtonStyle(
                        imageName: "arrow.forward",
                        foreground: Color("AppLabelColor"),
                        background: Color("PrimaryDarkColor")))
                    .padding(.trailing, 8)
            }
        })
        .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 100)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 0)
    }
}

#Preview {
    AllRecipesItem(recipe: recipePreviewData)
}
