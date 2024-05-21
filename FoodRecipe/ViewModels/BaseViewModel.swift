//
//  BaseViewModel.swift
//  FoodRecipe
//
//  Created by Raul Palade on 17/05/24.
//

import Foundation

class BaseViewModel: ObservableObject {
    @Published var countries: [Country] = []

    init() {
        loadCountries()
    }

    func loadCountries() {
        if let fileURL = Bundle.main.url(forResource: "countries", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([Country].self, from: data)
                countries = decodedData
            } catch {
                print("Error white loading data:", error)
            }
        } else {
            print("File JSON not found")
        }
    }
}
