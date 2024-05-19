//
//  SVGUtils.swift
//  FoodRecipe
//
//  Created by Raul Palade on 17/05/24.
//

import Foundation
import SwiftUI
import SVGKit

class SVGUtils {
    static func svgImageFromBase64(base64String: String) -> Image? {
        guard let data = Data(base64Encoded: base64String) else {
            return nil
        }

        guard let svgString = String(data: data, encoding: .utf8) else {
            return nil
        }

        guard let svgData = svgString.data(using: .utf8) else {
            return nil
        }

        let svgImage = SVGKImage(data: svgData)

        // Converte SVGKImage in UIImage
        if let uiImage = svgImage?.uiImage {
            return Image(uiImage: uiImage)
        } else {
            return nil
        }
    }
}
