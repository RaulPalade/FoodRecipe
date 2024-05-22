//
//  ChipButton.swift
//  FoodRecipe
//
//  Created by Raul Palade on 21/05/24.
//

import SwiftUI

struct ChipButton: View {
    let titleKey: LocalizedStringKey
    @Binding var isSelected: Bool

    var body: some View {
        Text(titleKey)
            .font(.custom("Cabin-Regular", size: 16))
            .lineLimit(1)
            .padding(.vertical, 9)
            .padding(.horizontal, 24)
            .foregroundColor(isSelected ? .white : Color("ButtonColor"))
            .background(isSelected ? Color("AppPrimaryColor") : Color("ChipColor"))
            .cornerRadius(40)
            .onTapGesture {
                isSelected.toggle()
            }
    }
}

#Preview {
    ChipButton(titleKey: "Breakfast", isSelected: .constant(true))
}
