//
//  LoginView.swift
//  FoodRecipe
//
//  Created by Raul Palade on 15/05/24.
//

import Foundation
import SwiftUI

struct OnboardingView: View {
    var data: [OnboardingItem] = onboardingData

    var body: some View {
        TabView {
            ForEach(data[0 ... 4]) { item in
                OnboardingCardItem(item: item)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    OnboardingView()
}
