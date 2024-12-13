//
//  MockWeatherNetworkRepository.swift
//  WeatherAppSwiftUI


// Mock Network Repository
class MockWeatherNetworkRepository: WeatherNetworkRepositoryProtocol {
    
    var mockResult: Result<WeatherForeCastResponseModel, DataTransferError> = .success(MockWeatherForeCastResponseModel().getWeatherForeCastResponseModel())
    
    func fetchWeatherForeCast(requestModel: [String : String], completion: @escaping (Result<WeatherForeCastResponseModel, DataTransferError>) -> Void) -> (any Cancellable)? {
        completion(mockResult)
        return nil
    }
}

// Mock Local Repository
class MockWeatherLocalRepository: WeatherLocalRepositoryProtocol {
    var mockSelectedCity: CityDetails?
    var mockLocations: [CityDetails] = []
    var mockResult: Result<[CityDetails], DataTransferError> = .success([])

    var updatedCity: CityDetails?

    func fetchLocations(completion: @escaping (Result<[CityDetails], DataTransferError>) -> Void) {
        completion(mockResult)
    }

    func updateSelectedCity(cityDetails: CityDetails) {
        updatedCity = cityDetails
    }

    func getSelectedCity() -> CityDetails? {
        return mockSelectedCity
    }
}
