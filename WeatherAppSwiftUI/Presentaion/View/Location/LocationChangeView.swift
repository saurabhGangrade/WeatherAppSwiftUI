//
//  LocationChangeView.swift
//  WeatherApp
//

import SwiftUI

struct LocationChangeView: View {
    @ObservedObject var viewModel: LocationChangeViewModel
    @State private var searchText = ""
    
    @Binding var presentedAsModal: Bool
    
    var body: some View {
        VStack {
            // Search Bar
            SearchBar(text: $searchText)
                .padding()
            
            // Show a loader if the data is still being fetched
            if viewModel.isLoading {
                ProgressView(Localizable.loading)
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }
            
            // TableView equivalent in SwiftUI
            List(viewModel.filteredCityDetails) { cityDetail in
                HStack {
                    Text(viewModel.getCityNameAndCountrycode(cityDetails: cityDetail))
                }
                .onTapGesture {
                    viewModel.updateSelectedCity(cityDetails: cityDetail)
                    self.presentedAsModal = false
                }
            }
            .onAppear {
                viewModel.fetchLocations()
            }
        }
        .navigationTitle("Change Location")
        .onChange(of: searchText, {
            // Triggering filtered results on text change
            viewModel.filterCities(with: searchText)
        })
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        TextField(Localizable.searchForCity, text: $text)
            .padding(7)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal)
            .autocapitalization(.none)
            .disableAutocorrection(true)
    }
}
