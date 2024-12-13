//
//  MockLocationChangeUseCase.swift
//  WeatherAppSwiftUI
//


class MockLocationChangeUseCase: LocationChangeUseCaseProtocol {
    var mockLocations: [CityDetails] = []
    var mockError: DataTransferError?
    var isUpdateCalled = false

    func fetchLocations(completion: @escaping (Result<[CityDetails], DataTransferError>) -> Void) {
        if let error = mockError {
            completion(.failure(error))
        } else {
            completion(.success(mockLocations))
        }
    }

    func updateSelectedCity(cityDetails: CityDetails) {
        isUpdateCalled = true
    }
}
