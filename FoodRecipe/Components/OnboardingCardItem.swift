//
//  OnboardingItem.swift
//  FoodRecipe
//
//  Created by Raul Palade on 19/05/24.
//

import SwiftUI

struct OnboardingCardItem: View {
    var item: OnboardingItem
    @State private var isAnimating: Bool = false

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Image(item.image)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                    .scaleEffect(isAnimating ? 1.0 : 0.6)

                Text(item.title)
                    .foregroundColor(Color.white)
                    .font(.custom("Cabin-Regular", size: 34))
                    .fontWeight(.heavy)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)

                Text(item.headline)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: 480)
                    .font(.custom("Cabin-Regular", size: 17))

                StartButton()
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                isAnimating = true
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(LinearGradient(gradient: Gradient(colors: item.gradientColors), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    OnboardingCardItem(item: onboardingData[0])
}
