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
            VStack {
                Spacer()
                VStack(spacing: 12) {
                    Text("Sign in now")
                        .font(.custom("Cabin-Regular", size: 26))
                        .padding([.leading, .trailing], 16)
                        .foregroundColor(Color("ButtonColor"))
                        .multilineTextAlignment(.center)
                        .bold()

                    Text("Please sign in to continue our app")
                        .font(.custom("Cabin-Regular", size: 16))
                        .padding([.leading, .trailing], 16)
                        .foregroundColor(Color("ButtonColor"))
                        .multilineTextAlignment(.center)
                }

                VStack(spacing: 24) {
                    TextField("Email", text: $email)
                        .padding(.all, 24)
                        .foregroundColor(Color("ButtonColor"))
                        .background(Color("LabelColor"))
                        .clipShape(RoundedRectangle(cornerRadius: 16))

                    HStack {
                        if isSecure {
                            SecureField("Password", text: $password)
                        } else {
                            TextField("Password", text: $password)
                        }
                        Button(action: {
                            isSecure.toggle()
                        }) {
                            Image(systemName: isSecure ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(Color("ButtonColor"))
                        }
                    }
                    .padding(.all, 24)
                    .background(Color("LabelColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    HStack {
                        Spacer()
                        NavigationLink {
                            ForgotPasswordView()
                        } label: {
                            HStack(spacing: 4) {
                                Text("Forgot Password?")
                                    .font(.custom("Cabin-Regular", size: 18))
                                    .bold()
                                    .foregroundColor(Color("ButtonColor"))
                                    .padding(.vertical, 18)
                                    .padding(.trailing, 8)
                            }
                        }
                        .buttonStyle(.borderless)
                        .foregroundColor(.white)
                    }

                }.padding([.horizontal], 24)

                VStack {
                    Button(action: signIn) {
                        Text("Login")
                            .font(.custom("Cabin-Regular", size: 18))
                            .bold()
                            .padding(.vertical, 18)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color("ButtonColor"))
                    .padding(.horizontal, 24)
                    .foregroundColor(.white)

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
                                .foregroundColor(Color("ButtonColor"))
                                .padding(.vertical, 16)
                        }
                        .buttonStyle(.borderless)
                        .foregroundColor(.white)
                    }
                    .padding(.horizontal, 24)
                }
                .padding(.top, 40)

                Spacer()

                HStack(spacing: 20) {
                    Image("icon_facebook")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .aspectRatio(contentMode: .fit)
                    Image("icon_instagram")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .aspectRatio(contentMode: .fit)
                    Image("icon_twitter")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .aspectRatio(contentMode: .fit)
                }
            }
            .padding(.bottom, 70)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color(.white))
        }
        .navigationDestination(
            isPresented: $isLoggingIn) {
                MainView()
        }
    }

    func signIn() {
        authViewModel.login(email: "raul@mail.com", password: "password")

        if authViewModel.authState == .signedIn {
            isLoggingIn = true
        }
    }
}

#Preview {
    LoginView()
}
