//
//  ForecastRowView.swift
//  WeatherAppSwiftUI
//

import SwiftUI

struct ForecastRowView: View {
    @ObservedObject var viewModel: WeatherForeCastViewModel
    var index: Int
    var expanded: Bool
    var onExpand: () -> Void
    
    var body: some View {
        Button(action: onExpand) {
            VStack {
                HStack {
                    Text(viewModel.getTodaysDay(index: index))
                        .foregroundColor(Color.white)
                        .font(.subheadline)
                        .frame(maxWidth: 100, alignment: .leading)
                    
                    Image(viewModel.getTemperatureTypeImage(index: index))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Spacer()
                    Text(viewModel.getMaxTemperature(index: index))
                        .foregroundColor(Color.white)
                        .font(.title3)
                        .frame(maxWidth: 90, alignment: .trailing)
                    Text(viewModel.getMinTemperature(index: index))
                        .foregroundColor(Color.white)
                        .font(.title3)
                        .frame(maxWidth: 90, alignment: .trailing)
                }
                .padding()
                
                if expanded {
                    WeatherCollectionView(viewModel: viewModel, index: index)
                        .padding(.top, 10)
                }
            }
            .background(Color.blue.opacity(0.4))
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }
}
