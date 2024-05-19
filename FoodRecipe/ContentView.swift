//
//  ContentView.swift
//  FoodRecipe
//
//  Created by Raul Palade on 14/05/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool?

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")

            Button(action: {
                isOnboarding = true
            }) {
                HStack(spacing: 8) {
                    Text("Re-Start")

                    Image(systemName: "arrow.right.circle")
                        .imageScale(.large)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    Capsule().strokeBorder(Color.black, lineWidth: 1.25)
                )
            }
            .accentColor(Color.black)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
