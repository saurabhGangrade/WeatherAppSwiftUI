//
//  WeatherLocalRepository.swift
//  WeatherApp

import Foundation

protocol WeatherLocalRepositoryProtocol {
    func fetchLocations(completion: @escaping (Result<[CityDetails], DataTransferError>) -> Void)
    func updateSelectedCity(cityDetails: CityDetails)
    func getSelectedCity() -> CityDetails?
}

final class WeatherLocalRepository: WeatherLocalRepositoryProtocol {

    private var selectedCity: CityDetails?

    func fetchLocations(completion: @escaping (Result<[CityDetails], DataTransferError>) -> Void) {
        if let url = Bundle.main.url(forResource: Constants.Resources.cityList, withExtension: Constants.Resources.extensionJSON) {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([CityDetails].self, from: data)
                completion(.success(jsonData))
            } catch {
                print("error:\(error)")
                completion(.failure(.noDataFound))
            }
        }
    }

    func updateSelectedCity(cityDetails: CityDetails) {
        selectedCity = cityDetails
    }

    func getSelectedCity() -> CityDetails? {
        return selectedCity
    }
}
