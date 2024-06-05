//
//  Chef.swift
//  FoodRecipe
//
//  Created by Raul Palade on 05/06/24.
//

import Foundation

import Foundation

struct Chef: Identifiable, Decodable {
    let id: String
    let name: String
    let email: String
    let about: String
    let imageUrl: String
    let country: [String: String]
}
