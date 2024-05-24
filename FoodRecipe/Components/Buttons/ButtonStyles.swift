//
//  ButtonStyles.swift
//  FoodRecipe
//
//  Created by Raul Palade on 24/05/24.
//

import Foundation
import SwiftUI

struct SquareButtonStyle: ButtonStyle {
    var imageName: String
    var foreground = Color.black
    var background = Color.white
    var width: CGFloat = 40
    var height: CGFloat = 40

    func makeBody(configuration: Configuration) -> some View {
        RoundedRectangle(cornerRadius: 10, style: .continuous)
            .fill(background)
            .overlay(Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(foreground)
                .padding(12)
            )
            .frame(width: width, height: height)
    }
}
