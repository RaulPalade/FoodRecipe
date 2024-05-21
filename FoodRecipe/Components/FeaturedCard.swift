//
//  FeaturedCard.swift
//  FoodRecipe
//
//  Created by Raul Palade on 21/05/24.
//

import SwiftUI

struct FeaturedCard: View {
    var title: String
    var authorName: String
    var time: String

    static let color0 = Color(red: 10 / 255, green: 97 / 255, blue: 102 / 255)

    static let color1 = Color(red: 112 / 255, green: 185 / 255, blue: 190 / 255)

    let gradient = Gradient(colors: [color0, color1])

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(LinearGradient(
                    gradient: gradient,
                    startPoint: .init(x: 0.00, y: 0.50),
                    endPoint: .init(x: 1.00, y: 0.50)
                ))

            VStack {
                HStack {
                    Spacer()
                        Image("foodForCard")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 90, maxHeight: 90)
                            .padding(.top, 10)
                        .padding(.trailing, 20)
                }
                Spacer()
            }

            Image("pattern1")
                .aspectRatio(contentMode: .fit)
                .offset(x: -120, y: -80)

            Image("pattern2")
                .aspectRatio(contentMode: .fit)
                .offset(x: -60, y: -20)

            Image("pattern3")
                .aspectRatio(contentMode: .fit)
                .offset(x: -160, y: -30)

            Image("pattern4")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .offset(x: -60, y: -40)
                .frame(maxWidth: 260)

            VStack {
                Spacer()
                Text(title)
                    .font(.custom("Cabin-Regular", size: 20))
                    .foregroundColor(.white)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)

                HStack(content: {
                    Image("profilePic")
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/ .fill/*@END_MENU_TOKEN@*/)
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 2)
                        )

                    Text(authorName)
                        .font(.custom("Cabin-Regular", size: 16))
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "clock")
                        .font(.custom("Cabin-Regular", size: 16))
                        .foregroundColor(.white)
                    Text(time)
                        .font(.custom("Cabin-Regular", size: 16))
                        .foregroundColor(.white)
                })
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
    }
}

#Preview {
    FeaturedCard(title: "Asian white noodle with extra seafood", authorName: "James Spader", time: "20 min")
}
