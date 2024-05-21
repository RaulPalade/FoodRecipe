//
//  SectionHeader.swift
//  FoodRecipe
//
//  Created by Raul Palade on 21/05/24.
//

import SwiftUI

struct SectionHeader: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.custom("Cabin-Regular", size: 20))
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    SectionHeader(title: "Featured")
}
