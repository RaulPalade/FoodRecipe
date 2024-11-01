//
//  LoginView.swift
//  FoodRecipe
//
//  Created by Raul Palade on 16/05/24.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var authViewModel = AuthViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var isSecure = true
    @State private var isLoggingIn = false

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
                        Text("Sign in now")
                            .font(.custom("Cabin-Regular", size: 26))
                            .padding([.leading, .trailing], 16)
                            .foregroundColor(Color("PrimaryDarkColor"))
                            .multilineTextAlignment(.center)
                            .bold()
                        Text("Please sign in to continue our app")
                            .font(.custom("Cabin-Regular", size: 16))
                            .padding([.leading, .trailing], 16)
                            .foregroundColor(Color("PrimaryDarkColor"))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.bottom, 20)

                    VStack(spacing: 24) {
                        CustomTextField(placeholder: "Email", text: $email)
                        VStack {
                            PasswordTextField(text: $password, isSecure: $isSecure, toggleAction: {
                                isSecure.toggle()
                            })
                            HStack {
                                Spacer()
                                NavigationLink {
                                    ForgotPasswordView()
                                } label: {
                                    HStack(spacing: 4) {
                                        Text("Forgot Password?")
                                            .font(.custom("Cabin-Regular", size: 16))
                                            .bold()
                                            .foregroundColor(Color("PrimaryDarkColor"))
                                            .padding(.vertical, 18)
                                            .padding(.trailing, 8)
                                    }
                                }
                                .buttonStyle(.borderless)
                            }
                        }
                        VStack {
                            DarkButton(text: "Login", action: signIn)
                            HStack {
                                Text("Don't have an account?")
                                    .font(.custom("Cabin-Regular", size: 16))
                                    .foregroundColor(Color(.gray))
                                    .padding(.vertical, 16)
                                NavigationLink {
                                    RegisterView()
                                } label: {
                                    Text("Sign up")
                                        .font(.custom("Cabin-Regular", size: 16))
                                        .bold()
                                        .foregroundColor(Color("PrimaryDarkColor"))
                                        .padding(.vertical, 16)
                                }
                                .buttonStyle(.borderless)
                                .foregroundColor(.white)
                            }
                            .padding(.horizontal, 24)
                        }
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
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }

    func signIn() {
        authViewModel.login(email: email, password: password)

        if authViewModel.authState == .signedIn {
            isLoggingIn = true
        }
    }
}

#Preview {
    LoginView()
}
