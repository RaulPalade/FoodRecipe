//
//  RecipeViewData.swift
//  FoodRecipe
//
//  Created by Raul Palade on 05/06/24.
//

import Foundation

import SwiftUI

struct RecipeViewData: Identifiable {
    let id: String
    let name: String
    let description: String
    let category: [String]
    var ingredients: [RecipeIngredient]
    let instructions: [String]
    let nutrition: Nutrition
    let author: RecipeAuthorViewData
    let rating: Double
    let time: String
    let createdAt: String
    let image: UIImage
}

struct RecipeAuthorViewData {
    let authorId: String
    let name: String
    let about: String
    let image: UIImage
}
