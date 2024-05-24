//
//  PopularRecipeCard.swift
//  FoodRecipe
//
//  Created by Raul Palade on 22/05/24.
//

import SwiftUI

struct PopularRecipeCard: View {    
    var recipe: Recipe
    @State var favourite: Bool
    var setFavourite: () -> Void

    var body: some View {
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
}

#Preview {
    PopularRecipeCard(recipe: recipePreviewData, favourite: true, setFavourite: {})
}
