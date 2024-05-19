//
//  CountryListRow.swift
//  FoodRecipe
//
//  Created by Raul Palade on 17/05/24.
//

import SwiftUI

struct CountryListRow: View {
    var country: Country
    var isSelected: Bool
    var onSelect: () -> Void

    var body: some View {
        HStack {
            Image(base64String: country.flag)
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .scaleEffect(1.2)
                .foregroundColor(.white)
            Text(country.name)
                .font(.custom("Cabin-Regular", size: 24))
                .foregroundColor(isSelected ? .white : Color("ButtonColor"))
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color(isSelected ? Color("ButtonColor") : .white))
        .onTapGesture {
            onSelect()
        }
    }
}

#Preview {
    CountryListRow(country: countryPreviewData, isSelected: true, onSelect: {})
}
