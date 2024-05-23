//
//  DarkButton.swift
//  FoodRecipe
//
//  Created by Raul Palade on 17/05/24.
//

import SwiftUI

struct DarkButton: View {
    var text: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.custom("Cabin-Regular", size: 18))
                .bold()
                .padding(.vertical, 18)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .tint(Color("PrimaryDarkColor"))
        .foregroundColor(.white)
    }
}

#Preview {
    DarkButton(text: "Click", action: { })
}
