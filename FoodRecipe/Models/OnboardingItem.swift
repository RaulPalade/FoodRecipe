//
//  OnboardingItem.swift
//  FoodRecipe
//
//  Created by Raul Palade on 19/05/24.
//

import Foundation
import SwiftUI

struct OnboardingItem: Identifiable {
    var id = UUID()
    var title: String
    var headline: String
    var image: String
    var gradientColors: [Color]
}
