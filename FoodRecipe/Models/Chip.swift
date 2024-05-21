//
//  Chip.swift
//  FoodRecipe
//
//  Created by Raul Palade on 21/05/24.
//

import Combine
import Foundation
import SwiftUI

struct Chip: Identifiable {
    let id = UUID()
    let titleKey: LocalizedStringKey
    @State var isSelected: Bool
}
