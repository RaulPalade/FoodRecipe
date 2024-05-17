//
//  ForgotPasswordView.swift
//  FoodRecipe
//
//  Created by Raul Palade on 16/05/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    @ObservedObject var authViewModel = AuthViewModel()
    @State private var email = ""
    @State private var isResettingPassword = false

    var body: some View {
        NavigationView {
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
                        Text("Restore password")
                            .font(.custom("Cabin-Regular", size: 26))
                            .padding([.leading, .trailing], 16)
                            .foregroundColor(Color("ButtonColor"))
                            .multilineTextAlignment(.center)
                            .bold()
                        Text("Enter your email to receive a reset link")
                            .font(.custom("Cabin-Regular", size: 16))
                            .padding([.leading, .trailing], 16)
                            .foregroundColor(Color("ButtonColor"))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.bottom, 20)

                    VStack(spacing: 24) {
                        CustomTextField(placeholder: "Email", text: $email)
                        DarkButton(text: "Reset password", action: resetPassword)
                    }
                    .padding([.horizontal], 24)
                    .padding(.bottom, 40)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
        }
        .navigationDestination(isPresented: $isResettingPassword) {
            MainView()
        }
    }

    func resetPassword() {
        authViewModel.resetPassword(email: email)
        isResettingPassword = true
    }
}

#Preview {
    ForgotPasswordView()
}
