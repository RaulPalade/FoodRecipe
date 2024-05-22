//
//  AppUser.swift
//  FoodRecipe
//
//  Created by Raul Palade on 14/05/24.
//

import Foundation

struct AppUser: Identifiable, Decodable {
    let id: String
    let name: String
    let email: String
    let about: String
    let imageUrl: String
    let favouriteRecipes: [String]
    let country: [String: String]
}
