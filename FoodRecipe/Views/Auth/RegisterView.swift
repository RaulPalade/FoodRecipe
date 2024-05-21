//
//  RegisterView.swift
//  FoodRecipe
//
//  Created by Raul Palade on 16/05/24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var authViewModel = AuthViewModel()
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isSecure = true
    @State private var isLoggingIn = false

    var body: some View {
        NavigationStack {
            ZStack {
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        Image("bottom")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width)
                    }
                }
                VStack {
                    Spacer()
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                    VStack(spacing: 12) {
                        Text("Sign up now")
                            .font(.custom("Cabin-Regular", size: 26))
                            .padding([.leading, .trailing], 16)
                            .foregroundColor(Color("ButtonColor"))
                            .multilineTextAlignment(.center)
                            .bold()
                        Text("Join us to unlock the full potential of our app")
                            .font(.custom("Cabin-Regular", size: 16))
                            .padding([.leading, .trailing], 16)
                            .foregroundColor(Color("ButtonColor"))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.bottom, 20)

                    VStack(spacing: 24) {
                        CustomTextField(placeholder: "Name", text: $name)
                        CustomTextField(placeholder: "Email", text: $email)
                        PasswordTextField(text: $password, isSecure: $isSecure, toggleAction: {
                            isSecure.toggle()
                        })
                        DarkButton(text: "Sign up", action: register)
                    }
                    .padding([.horizontal], 24)
                    .padding(.bottom, 40)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
        }
        .navigationDestination(isPresented: $isLoggingIn) {
            TabScreenView()
        }
    }

    func register() {
    }
}

#Preview {
    RegisterView()
}
