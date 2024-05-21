//
//  ProfileView.swift
//  FoodRecipe
//
//  Created by Raul Palade on 20/05/24.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var authViewModel = AuthViewModel()

    var body: some View {
        DarkButton(text: "Logout", action: signOut)
    }

    func signOut() {
        authViewModel.logout()
    }
}

#Preview {
    ProfileView()
}
