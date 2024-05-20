//
//  TabScreenView.swift
//  FoodRecipe
//
//  Created by Raul Palade on 20/05/24.
//

import SwiftUI

enum Tab {
    case home, goals, settings
}

enum HomeNavigation: Hashable {
    case recipeDetail
}

struct TabScreenView: View {
    @State private var selectedTab: Tab = .home
    @State private var homeNavigationStack: [HomeNavigation] = []

    var body: some View {
        TabView(selection: tabSelection()) {
            HomeView(path: $homeNavigationStack)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(Tab.home)

            RecipesView()
                .tabItem {
                    Label("Recipes", systemImage: "flag")
                }
                .tag(Tab.goals)

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "gear")
                }
                .tag(Tab.settings)
        }
    }
}

extension TabScreenView {
    private func tabSelection() -> Binding<Tab> {
        Binding { // this is the get block
            self.selectedTab
        } set: { tappedTab in
            if tappedTab == self.selectedTab {
                // User tapped on the tab twice == Pop to root view
                if homeNavigationStack.isEmpty {
                    // User already on home view, scroll to top
                } else {
                    homeNavigationStack = []
                }
            }
            // Set the tab to the tabbed tab
            self.selectedTab = tappedTab
        }
    }
}

#Preview {
    TabScreenView()
}
