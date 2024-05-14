//
//  FoodCategory.swift
//  FoodRecipe
//
//  Created by Raul Palade on 14/05/24.
//

import Foundation

struct FoodCategory: Identifiable, Decodable {
    let id: String
    let name: String
    let imageUrl: String
}
