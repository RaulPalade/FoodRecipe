//
//  ChipViewModel.swift
//  FoodRecipe
//
//  Created by Raul Palade on 21/05/24.
//

import Foundation

class ChipViewModel: ObservableObject {
    @Published var chipArray: [Chip] = [
        Chip(titleKey: "Breakfast"),
        Chip(titleKey: "Lunch"),
        Chip(titleKey: "Dinner"),
    ]

    @Published var selectedChipId: UUID?

    func selectChip(_ chip: Chip) {
        if selectedChipId == chip.id {
            selectedChipId = nil
        } else {
            selectedChipId = chip.id
        }
    }

    func isChipSelected(_ chip: Chip) -> Bool {
        return selectedChipId == chip.id
    }
}
