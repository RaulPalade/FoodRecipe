//
//  MainView.swift
//  FoodRecipe
//
//  Created by Raul Palade on 15/05/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var authViewModel = AuthViewModel()

    var body: some View {
        VStack {
            Text("Home View")
        }
    }
}

#Preview {
    HomeView()
}
