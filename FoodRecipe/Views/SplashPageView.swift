//
//  SplashPageView.swift
//  FoodRecipe
//
//  Created by Raul Palade on 21/05/24.
//

import SwiftUI

struct SplashPageView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack {
            // Sostituisci questa immagine con l'immagine o animazione desiderata
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .onAppear {
                    // Simula un breve ritardo per mostrare la splash screen
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        authViewModel.checkAuthStatus()
                    }
                }
        }
    }
}

#Preview {
    SplashPageView()
}
