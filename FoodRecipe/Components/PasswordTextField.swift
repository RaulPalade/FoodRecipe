//
//  PasswordTextField.swift
//  FoodRecipe
//
//  Created by Raul Palade on 17/05/24.
//

import SwiftUI

struct PasswordTextField: View {
    @Binding var text: String
    @Binding var isSecure: Bool
    var toggleAction: () -> Void

    var body: some View {
        HStack {
            if isSecure {
                SecureField("Password", text: $text)
                    .autocapitalization(.none)
            } else {
                TextField("Password", text: $text)
                    .autocapitalization(.none)
            }
            Button(action: toggleAction) {
                Image(systemName: isSecure ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(Color("ButtonColor"))
            }
        }
        .padding(.all, 24)
        .background(Color("AppLabelColor"))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    PasswordTextField(text: .constant(""), isSecure: .constant(true)) {
    }
}
