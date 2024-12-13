//
//  WeatherForeCastUseCase.swift
//  WeatherApp


import Foundation

protocol WeatherForeCastUseCaseProtocol {
    func fetchWeatherForeCast(completion: @escaping (Result<WeatherForeCastResponseModel,
                                                     DataTransferError>) -> Void)
    func fetchSelectedCityName() -> String
}

final class WeatherForeCastUseCase: WeatherForeCastUseCaseProtocol {
    private let repository: WeatherRepositoryProtocol

    init(repository: WeatherRepositoryProtocol) {
        self.repository = repository
    }

    func fetchWeatherForeCast(completion: @escaping (Result<WeatherForeCastResponseModel,
                                                     DataTransferError>) -> Void) {
        _ = repository.fetchWeatherForeCast(completion: { result in
            completion(result)
        })
    }
    
    func fetchSelectedCityName() -> String {
        return repository.getSelectedCity()?.cityName ?? ""
    }
}
