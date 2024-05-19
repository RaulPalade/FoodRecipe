//
//  StartButton.swift
//  FoodRecipe
//
//  Created by Raul Palade on 19/05/24.
//

import SwiftUI

struct StartButton: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool?

    var body: some View {
        Button(action: {
            isOnboarding = false
            if let isOnboarding = isOnboarding {
                print("isOnboarding:", isOnboarding) // Stampa il valore effettivo di isOnboarding
            } else {
                print("isOnboarding is nil")
            }
        }) {
            HStack(spacing: 8) {
                Text("Start")
                    .font(.custom("Cabin-Regular", size: 17))
                Image(systemName: "arrow.right.circle")
                    .imageScale(.large)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                Capsule().strokeBorder(Color.white, lineWidth: 1.25)
            )
        }
        .accentColor(Color.white)
    }
}

#Preview {
    StartButton()
}
