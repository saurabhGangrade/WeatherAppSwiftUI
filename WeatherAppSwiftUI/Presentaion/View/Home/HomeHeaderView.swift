//
//  HomeHeaderView.swift
//  WeatherAppSwiftUI
//

import SwiftUI

struct HomeHeaderView: View {
    @ObservedObject var viewModel: WeatherForeCastViewModel
    
    var body: some View {
        // Location Button
        Button(action: {
            viewModel.isCityNameNotFound = true
        }) {
            Image(Constants.Resources.locationImage)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .opacity(viewModel.getCityName().isEmpty ? 0 : 1)
            Text(viewModel.getCityName())
                .font(.title)
                .foregroundColor(.white)
        }
        .padding(.top, 20)
        
        // Header View
        VStack(alignment: .center, spacing: 0) {
            HStack {
                // Weather Type Image and Info
                Image(viewModel.getTemperatureTypeImage(index: 0))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .opacity(viewModel.getTemperatureType(index: 0).isEmpty ? 0 : 1)
                Text(viewModel.getTemperatureType(index: 0))
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            Text(viewModel.getCurrentTemperature(index: 0))
                .font(.title)
                .foregroundColor(.white)
                .padding(.top, 0)
            
            Text(viewModel.getTodaysDate(index: 0))
                .font(.subheadline)
                .foregroundColor(.white)
        }
    }
}
