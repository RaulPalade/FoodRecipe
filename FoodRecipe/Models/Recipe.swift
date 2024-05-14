//
//  Recipe.swift
//  FoodRecipe
//
//  Created by Raul Palade on 14/05/24.
//

import Foundation

struct Recipe: Identifiable, Decodable {
    let id: String
    let name: String
    let description: String
    let category: [FoodCategory]
    let ingredients: [RecipeIngredient]
    let instructions: [String]
    let nutritions: Nutrition
    let authorId: String
    let rating: Double
    let time: String
    let createdAt: Date
    let imageUrl: String
}

struct RecipeIngredient: Identifiable, Decodable {
    let id: String
    let name: String
    let imageUrl: String
    let quantity: String
}
