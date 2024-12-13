//
//  LocationChangeViewModel.swift
//  WeatherApp

import SwiftUI

class LocationChangeViewModel: ObservableObject {
    private let useCase: LocationChangeUseCaseProtocol

    @Published var cityDetails: [CityDetails] = []
    @Published var filteredCityDetails: [CityDetails] = []
    @Published var isLoading: Bool = false
    
    init(useCase: LocationChangeUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchLocations() {
        self.isLoading = true
        useCase.fetchLocations(completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let responseDTO):
                self.cityDetails = responseDTO
                self.filteredCityDetails = responseDTO
                self.isLoading = false
            case .failure(let error):
                print("Function: \(#function), line: \(#line) Error in update: \(error)")
            }
        })
    }

    
    func filterCities(with searchText: String) {
        if searchText.isEmpty {
            self.filteredCityDetails = self.cityDetails
        } else {
            self.filteredCityDetails = cityDetails.filter { $0.cityName.lowercased().hasPrefix(searchText.lowercased()) }
        }
    }
    
    func updateSelectedCity(cityDetails: CityDetails) {
        // Update the selected city logic
        useCase.updateSelectedCity(cityDetails: cityDetails)
    }
    
    func getCityNameAndCountrycode(cityDetails: CityDetails) -> String {
        guard let cityCountryCode = cityDetails.cityCountryCode else {
            return cityDetails.cityName
        }
        return "\(cityDetails.cityName), \(cityCountryCode)"
    }
    
    deinit {
    }
}
