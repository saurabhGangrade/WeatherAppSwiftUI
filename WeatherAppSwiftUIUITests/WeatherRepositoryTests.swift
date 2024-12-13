//
//  WeatherRepositoryTests.swift
//  WeatherAppSwiftUI
//
//  Created by Saurabh Gangrade on 12/12/24.
//


import XCTest
@testable import WeatherAppSwiftUI

class WeatherRepositoryTests: XCTestCase {
    
    var weatherRepository: WeatherRepository!
    var mockNetworkRepository: MockWeatherNetworkRepository!
    var mockLocalRepository: MockWeatherLocalRepository!

    override func setUp() {
        super.setUp()
        mockNetworkRepository = MockWeatherNetworkRepository()
        mockLocalRepository = MockWeatherLocalRepository()
        weatherRepository = WeatherRepository(netWorkRepository: mockNetworkRepository,
                                              localRepository: mockLocalRepository)
    }

    override func tearDown() {
        weatherRepository = nil
        mockNetworkRepository = nil
        mockLocalRepository = nil
        super.tearDown()
    }

    // MARK: - Test fetchWeatherForeCast

    func testFetchWeatherForeCast_Success() {
        // Given: Mock city details and a successful response from the network repository
        
        let cityDetails = MockCityDetailsResponseModel().getCityDetailsResponseModel()
        mockLocalRepository.mockSelectedCity = cityDetails
        let mockResponse = MockWeatherForeCastResponseModel().getWeatherForeCastResponseModel()
        mockNetworkRepository.mockResult = .success(mockResponse)
        
        let expectation = self.expectation(description: "Fetch weather forecast")

        // When: Call the fetchWeatherForeCast method
        _ = weatherRepository.fetchWeatherForeCast { result in
            // Then: Verify the result
            switch result {
            case .success(let response):
                if let cityName = response.cityDetails?.cityName {
                    XCTAssertEqual(cityName, "Test City", "City name should be Test City.")
                } else {
                    XCTFail("success but cityName nil.")
                }
                
            case .failure:
                XCTFail("Expected success but got failure.")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testFetchWeatherForeCast_Failure_NoSelectedCity() {
        // Given: No selected city
        mockLocalRepository.mockSelectedCity = nil

        let expectation = self.expectation(description: "Fetch weather forecast with no selected city")

        // When: Call the fetchWeatherForeCast method
        _ = weatherRepository.fetchWeatherForeCast { result in
            // Then: Verify the result
            switch result {
            case .success:
                XCTFail("Expected failure but got success.")
            case .failure(let error):
                XCTAssertEqual(error, DataTransferError.noSelectedCtyFound, "Expected noSelectedCtyFound error.")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testFetchWeatherForeCast_Failure_NetworkError() {
        // Given: Mock city details and a network error
        let cityDetails = MockCityDetailsResponseModel().getCityDetailsResponseModel()
        mockLocalRepository.mockSelectedCity = cityDetails
        mockNetworkRepository.mockResult = .failure(DataTransferError.networkFailure(.notConnected))
        
        let expectation = self.expectation(description: "Fetch weather forecast with network error")

        // When: Call the fetchWeatherForeCast method
        _ = weatherRepository.fetchWeatherForeCast { result in
            // Then: Verify the result
            switch result {
            case .success:
                XCTFail("Expected failure but got success.")
            case .failure(let error):
                XCTAssertEqual(error, DataTransferError.networkFailure(.notConnected), "Expected networkError.")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    // MARK: - Test fetchLocations

    func testFetchLocations_Success() {
        // Given: Mock a successful response from the local repository
        let cityDetails = MockCityDetailsResponseModel().getCityDetailsResponseModel()
//        mockLocalRepository.mockSelectedCity = cityDetails
        mockLocalRepository.mockLocations = [cityDetails]
        mockLocalRepository.mockResult = .success(mockLocalRepository.mockLocations)
        
        let expectation = self.expectation(description: "Fetch locations")

        // When: Call the fetchLocations method
        weatherRepository.fetchLocations { result in
            // Then: Verify the result
            switch result {
            case .success(let locations):
                XCTAssertEqual(locations.count, 1, "There should be one location.")
            case .failure:
                XCTFail("Expected success but got failure.")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testFetchLocations_Failure() {
        // Given: Mock a failure response from the local repository
        mockLocalRepository.mockResult = .failure(DataTransferError.noDataFound)

        let expectation = self.expectation(description: "Fetch locations with failure")

        // When: Call the fetchLocations method
        weatherRepository.fetchLocations { result in
            // Then: Verify the result
            switch result {
            case .success:
                XCTFail("Expected failure but got success.")
            case .failure(let error):
                XCTAssertEqual(error, DataTransferError.noDataFound, "No Data Found.")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    // MARK: - Test updateSelectedCity and getSelectedCity

    func testUpdateSelectedCity() {
        // Given: A city details to update
        let cityDetails = MockCityDetailsResponseModel().getCityDetailsResponseModel()

        // When: Update the selected city
        weatherRepository.updateSelectedCity(cityDetails: cityDetails)

        // Then: Verify that the selected city was updated in the local repository
        XCTAssertEqual(mockLocalRepository.updatedCity?.coord.cityLatitude, 1.12, "Latitude should be 1.12")
        XCTAssertEqual(mockLocalRepository.updatedCity?.coord.cityLongitude, 2.31, "Longitude should be 2.31")
    }

    func testGetSelectedCity() {
        // Given: Mock a selected city
        let cityDetails = MockCityDetailsResponseModel().getCityDetailsResponseModel()
        mockLocalRepository.mockSelectedCity = cityDetails
        
        // When: Get the selected city
        let selectedCity = weatherRepository.getSelectedCity()

        // Then: Verify the selected city is returned correctly
        XCTAssertEqual(selectedCity?.coord.cityLatitude, 1.12, "Latitude should be 1.12")
        XCTAssertEqual(selectedCity?.coord.cityLongitude, 2.31, "Longitude should be 2.31")
    }
}

