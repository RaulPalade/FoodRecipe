//
//  CountryList.swift
//  FoodRecipe
//
//  Created by Raul Palade on 17/05/24.
//

import SwiftUI

struct CountryList: View {
    @EnvironmentObject var baseViewModel: BaseViewModel
    @Binding var selectedCountry: Country?
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Select your country")
                .font(.custom("Cabin-Regular", size: 26))
                .padding([.leading, .trailing], 16)
                .foregroundColor(Color("ButtonColor"))
                .multilineTextAlignment(.center)
                .bold()
            List {
                Section {
                    ForEach(baseViewModel.countries.indices, id: \.self) { index in
                        CountryListRow(
                            country: baseViewModel.countries[index],
                            isSelected: baseViewModel.countries[index] == selectedCountry
                        ) {
                            selectedCountry = baseViewModel.countries[index]
                            print(selectedCountry)
                        }
                    }.listRowSeparator(.hidden)
                }
                .listRowInsets(.init())
            }
            .listStyle(PlainListStyle())

            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Confirm")
                    .font(.custom("Cabin-Regular", size: 18))
                    .bold()
                    .padding(.vertical, 18)
                    .frame(maxWidth: .infinity)
                    .background(Color("ButtonColor"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal, 16)
        }
    }
}

let baseViewModel: BaseViewModel = {
    let baseViewModel = BaseViewModel()
    baseViewModel.countries = countriesPreviewData
    return baseViewModel
}()

/*#Preview {
    CountryList(selectedCountry: <#T##Binding<Country?>#>).environmentObject(baseViewModel)
}*/
