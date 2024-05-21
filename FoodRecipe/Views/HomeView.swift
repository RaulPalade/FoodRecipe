//
//  MainView.swift
//  FoodRecipe
//
//  Created by Raul Palade on 15/05/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var authViewModel = AuthViewModel()
    @StateObject private var recipeViewModel = RecipeViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Featured")
                }
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        VStack(alignment: .leading, content: {
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: "sun.max")
                                        .symbolRenderingMode(.palette)
                                        .foregroundStyle(Color("AppPrimaryColor"), .primary)
                                    Text("Good Morning")
                                        .font(.custom("Cabin-Regular", size: 20))
                                        .foregroundColor(Color("ButtonColor"))
                                        .multilineTextAlignment(.center)
                                }
                                if let user = authViewModel.currentUser {
                                    Text(user.email ?? "")
                                        .font(.custom("Cabin-Regular", size: 24))
                                        .foregroundColor(Color("ButtonColor"))
                                        .multilineTextAlignment(.center)
                                        .bold()
                                }
                            }
                        })
                    }
                }
            }
        }
        .padding(.vertical, 12)
        .environmentObject(recipeViewModel)
    }
}

#Preview {
    HomeView()
}
