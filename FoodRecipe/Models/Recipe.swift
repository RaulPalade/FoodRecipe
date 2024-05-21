//
//  Recipe.swift
//  FoodRecipe
//
//  Created by Raul Palade on 14/05/24.
//

import FirebaseFirestore
import Foundation

struct Recipe: Identifiable, Decodable {
    let id: String
    let name: String
    let description: String
    let category: [String]
    var ingredients: [RecipeIngredient] = []
    let instructions: [String]
    let nutrition: Nutrition
    let authorId: String
    let rating: Double
    let time: String
    let createdAt: String
    let imageUrl: String
}

struct RecipeIngredient: Identifiable, Decodable {
    let id: String
    let name: String
    let imageUrl: String
    let quantity: String
}
