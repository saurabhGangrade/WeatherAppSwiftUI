//
//  HomeListView.swift
//  WeatherAppSwiftUI
//

import SwiftUI

struct HomeListView: View {
    @ObservedObject var viewModel: WeatherForeCastViewModel
    @State private var expandedIndexPath: IndexPath?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                // Forecast List
                ForEach(0..<viewModel.getDayCount(), id: \.self) { index in
                    ForecastRowView(
                        viewModel: viewModel,
                        index: index,
                        expanded: expandedIndexPath == IndexPath(row: index, section: 0),
                        onExpand: {
                            expandedIndexPath = expandedIndexPath == IndexPath(row: index, section: 0) ? nil : IndexPath(row: index, section: 0)
                        }
                    )
                }
            }
            .padding()
        }
    }
}
