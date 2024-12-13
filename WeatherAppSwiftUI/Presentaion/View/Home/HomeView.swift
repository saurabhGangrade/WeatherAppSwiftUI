//
//  ContentView.swift
//  WeatherAppSwiftUI
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: WeatherForeCastViewModel
    @State var showsInternetAlert = false
    
    // Initializer to inject the view model
    init(viewModel: WeatherForeCastViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView(Localizable.loading)
                        .progressViewStyle(CircularProgressViewStyle())
                        .tint(.white)
                        .padding()
                        .foregroundStyle(.white)
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                    Button(action: {
                        callApi()
                    }) {
                        Text(Localizable.tryAgain)
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .padding()
                } else {
                    VStack(alignment: .center) {
                        // Header View
                        HomeHeaderView(viewModel: viewModel)
                        
                        // List
                        HomeListView(viewModel: viewModel)
                    }
                }
            }
            //.navigationTitle("Weather")
            .background(
                Image(Constants.Resources.weatherBGImage)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            )
        }
        .sheet(isPresented: $viewModel.isCityNameNotFound, onDismiss: {
            if viewModel.isCityModified() {
                callApi()
            }
        }) {
            // Show Location Screen
            viewModel.showLocationView($viewModel.isCityNameNotFound)
        }
        .alert(isPresented: self.$showsInternetAlert) {
            Alert(title: Text(Localizable.noInternetTitle), message: Text(Localizable.noInternetMsg), dismissButton: .default(Text(Localizable.ok), action: ({
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    callApi()
                }
            })))
        }
    }
    
    private func callApi() {
        if isNetworkConnectionExist() {
            fetchWeatherData()
        } else {
            showNoInternetAlert()
        }
    }
    
    private func fetchWeatherData() {
        viewModel.showLoaderAndRestetErrorMessage()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            viewModel.fetchWeatherDetails()
        }
    }
    
    private func showNoInternetAlert() {
        // Handle no internet case, show an alert or something similar
        showsInternetAlert = true
        viewModel.errorMessage = Localizable.noInternetError
    }
}
