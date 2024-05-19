//
//  MainView.swift
//  FoodRecipe
//
//  Created by Raul Palade on 15/05/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var authViewModel = AuthViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Benvenuto!")
                    .font(.title)
                    .fontWeight(.bold)

                Spacer()

                Button("Logout") {
                    authViewModel.logout()
                
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
            }
            .navigationTitle("Main")
        }
    }
}

#Preview {
    MainView()
}
