//
//  LoginView.swift
//  FoodRecipe
//
//  Created by Raul Palade on 15/05/24.
//

import Foundation
import SwiftUI

struct OnboardingView: View {
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Image("v2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 30)

                    Image("Onboarding")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 110)
                        .frame(width: 300)
                }

                Spacer()

                Text("Help your path to health goals with happiness")
                    .font(.custom("Cabin-Regular", size: 28))
                    .padding([.leading, .trailing], 16)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .bold()

                VStack {
                    NavigationLink {
                        LoginView()
                    } label: {
                        HStack(spacing: 4) {
                            Text("Go to login")
                                .font(.custom("Cabin-Regular", size: 18))
                                .bold()
                                .padding(.vertical, 18)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color("ButtonColor"))
                    .padding(.horizontal, 24)
                    .foregroundColor(.white)

                    NavigationLink {
                        LoginView()
                    } label: {
                        HStack(spacing: 4) {
                            Text("Create new account")
                                .font(.custom("Cabin-Regular", size: 18))
                                .bold()
                                .padding(.vertical, 18)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .buttonStyle(.borderless)
                    .padding(.horizontal, 24)
                    .foregroundColor(.white)
                }
                .padding(.top, 24)
            }
            .padding(.bottom, 70)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color("AppPrimaryColor"))
        }
    }
}

#Preview {
    OnboardingView()
}
