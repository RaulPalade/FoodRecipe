//
//  PopularRecipeCard.swift
//  FoodRecipe
//
//  Created by Raul Palade on 22/05/24.
//

import SwiftUI

struct PopularRecipeCard: View {
    var recipe: RecipeViewData
    @State var favourite: Bool
    var setFavourite: () -> Void

    var body: some View {
        VStack {
            ZStack {
                Image(uiImage: recipe.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 12)
                    .frame(maxWidth: .infinity)

                Image(systemName: favourite ? "heart.fill" : "heart")
                    .font(.custom("Cabin-Regular", size: 22))
                    .foregroundColor(favourite ? .red : Color("PrimaryDarkColor"))
                    .frame(width: 40, height: 40)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)
                    .offset(x: 65, y: -34)
                    .onTapGesture {
                        favourite.toggle()
                        setFavourite()
                    }
            }

            Text(recipe.name)
                .font(.custom("Cabin-Regular", size: 16))
                .foregroundColor(Color("PrimaryDarkColor"))
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .padding(.horizontal, 8)

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
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}


#Preview {
    PopularRecipeCard(recipe: recipePreviewData, favourite: true, setFavourite: {})
}
