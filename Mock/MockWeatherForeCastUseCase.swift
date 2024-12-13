//
//  MockWeatherForeCastUseCase.swift
//  WeatherAppSwiftUITests
//

import XCTest
import SwiftUI
@testable import WeatherAppSwiftUI

// Mock WeatherForeCastUseCaseProtocol
class MockWeatherForeCastUseCase: WeatherForeCastUseCaseProtocol {
    var mockCityName: String
    var shouldReturnError: Bool
    var isSelectedCityFound: Bool
    var mockWeatherResponse: WeatherForeCastResponseModel?
    var isActionCalled = false
    
    init(cityName: String = "Test City", shouldReturnError: Bool = false, isSelectedCityFound: Bool = true, mockWeatherResponse: WeatherForeCastResponseModel? = nil) {
        self.mockCityName = cityName
        self.shouldReturnError = shouldReturnError
        self.isSelectedCityFound = isSelectedCityFound
        self.mockWeatherResponse = mockWeatherResponse
    }
    
    func fetchWeatherForeCast(completion: @escaping (Result<WeatherForeCastResponseModel, DataTransferError>) -> Void) {
        guard isSelectedCityFound else {
            completion(.failure(.noSelectedCtyFound))
            return
        }
        if shouldReturnError {
            completion(.failure(.noDataFound))  // Simulate failure
        } else if let response = mockWeatherResponse {
            completion(.success(response))  // Simulate success
        } else {
            completion(.failure(.noResponse))  // Default failure if no mock data provided
        }
    }
    
    func fetchSelectedCityName() -> String {
        return mockCityName
    }
}
