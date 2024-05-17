//
//  TextField.swift
//  FoodRecipe
//
//  Created by Raul Palade on 17/05/24.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
        TextField(placeholder: placeholder, text: $text)
            .padding(.all, 24)
            .foregroundColor(Color("ButtonColor"))
            .background(Color("AppLabelColor"))
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    TextField(placeholder: "Email", text: .constant(""))
}
