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
                    withAnimation(.bouncy()) {
                        selectedTab = tab
                    }
                } label: {
                    Image(systemName: tab.rawValue)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(selectedTab == tab ? Color("PrimaryLightColor") : .white)
                        .fontWeight(selectedTab == tab ? .bold : .regular)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width - 20, height: 60)
        .background(Color("PrimaryDarkColor").opacity(0.9), in: RoundedRectangle(cornerRadius: 100))
    }
}

#Preview {
    CustomTabBarView(selectedTab: .constant(.home))
}
