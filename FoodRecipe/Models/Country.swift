//
//  Country.swift
//  FoodRecipe
//
//  Created by Raul Palade on 17/05/24.
//

import Foundation

struct Country: Identifiable, Decodable, Hashable {
    var id: Int
    var name: String
    var isoAlpha2: String
    var flag: String
}
