//
//  ChipViewModel.swift
//  FoodRecipe
//
//  Created by Raul Palade on 21/05/24.
//

import Foundation

class ChipViewModel: ObservableObject {
    @Published var chipArray: [Chip] = [
        Chip(titleKey: "Breakfast", isSelected: false),
        Chip(titleKey: "Lunch", isSelected: false),
        Chip(titleKey: "Dinner", isSelected: false),
    ]
}
