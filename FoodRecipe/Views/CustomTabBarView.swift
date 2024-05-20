//
//  CustomTabBarView.swift
//  FoodRecipe
//
//  Created by Raul Palade on 20/05/24.
//

import SwiftUI

struct CustomTabBarView: View {
    @Binding var selectedTab: Tab

    var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                Button {
                    withAnimation(.spring()) {
                        selectedTab = tab
                    }
                } label: {
                    Image(systemName: tab.rawValue)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(selectedTab == tab ? .blue : .gray)
                        .fontWeight(selectedTab == tab ? .bold : .regular)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width - 20, height: 60)
        .background(Color.cyan.opacity(0.3), in: RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    CustomTabBarView()
}
