//
//  Nutrition.swift
//  FoodRecipe
//
//  Created by Raul Palade on 14/05/24.
//

import Foundation

struct Nutrition: Identifiable, Decodable {
    let id: String
    let calories: Double
    let carb: Double
    let proteins: Double
    let fats: Double
}
