//
//  Extensions.swift
//  FoodRecipe
//
//  Created by Raul Palade on 17/05/24.
//

import Foundation
import SwiftUI

extension Image {
    init?(base64String: String) {
        guard let data = Data(base64Encoded: base64String) else { return nil }
        guard let uiImage = UIImage(data: data) else { return nil }
        self = Image(uiImage: uiImage)
    }
}
