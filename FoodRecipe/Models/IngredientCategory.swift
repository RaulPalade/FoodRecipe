//
//  IngredientCategory.swift
//  FoodRecipe
//
//  Created by Raul Palade on 14/05/24.
//

import Foundation

struct IngredientCategory: Identifiable, Decodable {
    let id: String
    let name: String
    let imageUrl: String
    let ingredients: [Ingredient]
}
