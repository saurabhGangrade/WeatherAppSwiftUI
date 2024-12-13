//
//  WeatherCollectionView.swift
//  WeatherAppSwiftUI
//

import SwiftUI
struct WeatherCollectionView: View {
    @ObservedObject var viewModel: WeatherForeCastViewModel
    var index: Int
    
    var body: some View {
        let weatherDetails = viewModel.getWeatherDetailsForFullDay(day: index)
        Divider()
            .overlay(.white)
            .padding()
        
        ScrollView(.horizontal){
            LazyHGrid(rows: [GridItem(.fixed(80))], spacing: 10) {
                ForEach(0..<weatherDetails.count, id: \.self) { itemIndex in
                    WeatherCollectionCell(weatherDetail: weatherDetails[itemIndex], isNow: (index == 0 && itemIndex == 0))
                }
            }
        }
        .padding(.leading, 10)
        .padding(.bottom, 10)
    }
}
