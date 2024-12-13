//
//  WeatherCollectionCell.swift
//  WeatherAppSwiftUI
//

import SwiftUI

struct WeatherCollectionCell: View {
    var weatherDetail: WeatherForeCastDetails
    var isNow: Bool
    
    var body: some View {
        VStack {
            Text(isNow ? Localizable.now : weatherDetail.time)
                .font(.caption)
                .padding(4)
                .foregroundColor(Color.white)
            Image(weatherDetail.weatherIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            Text("\(weatherDetail.temperature)°C")
                .font(.caption)
                .foregroundColor(Color.white)
        }
        .frame(width: 55)
        .cornerRadius(8)
    }
}
