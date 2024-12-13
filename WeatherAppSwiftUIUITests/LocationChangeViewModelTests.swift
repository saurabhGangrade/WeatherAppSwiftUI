//
//  LocationChangeViewModelTests.swift
//  WeatherAppSwiftUI
//


import XCTest
import SwiftUI
@testable import WeatherAppSwiftUI

class LocationChangeViewModelTests: XCTestCase {
    
    var viewModel: LocationChangeViewModel!
    var mockUseCase: MockLocationChangeUseCase!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockLocationChangeUseCase()
        viewModel = LocationChangeViewModel(useCase: mockUseCase)
    }

    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        super.tearDown()
    }
    
    // Test: Ensure locations are fetched correctly
    func testFetchLocationsSuccess() {
        // Given
        let mockCityDetails: [CityDetails] = [MockCityDetailsResponseModel().getCityDetailsResponseModel()]
        mockUseCase.mockLocations = mockCityDetails
        
        // When
        viewModel.fetchLocations()
        
        // Then
        XCTAssertEqual(viewModel.cityDetails, mockCityDetails)
        XCTAssertEqual(viewModel.filteredCityDetails, mockCityDetails)
        XCTAssertFalse(viewModel.isLoading)
    }

    // Test: Ensure locations handle failure case
    func testFetchLocationsFailure() {
        // Given
        mockUseCase.mockError = .networkFailure(.notConnected)
        
        // When
        viewModel.fetchLocations()
        
        // Then
        XCTAssertTrue(viewModel.cityDetails.isEmpty)
        XCTAssertTrue(viewModel.filteredCityDetails.isEmpty)
//        XCTAssertFalse(viewModel.isLoading)
    }

    // Test: Ensure cities are filtered correctly
    func testFilterCities() {
        // Given
        let mockCityDetails: [CityDetails] = MockCityDetailsResponseModel().getCityDetailsResponseModelArray()
        viewModel.cityDetails = mockCityDetails
        
        // When
        viewModel.filterCities(with: "Test")
        
        // Then
        XCTAssertEqual(viewModel.filteredCityDetails.count, 2)
        XCTAssertTrue(viewModel.filteredCityDetails.contains { $0.cityName == "Test City" })
        XCTAssertTrue(viewModel.filteredCityDetails.contains { $0.cityName == "Test City1" })
        
        // Test filtering with an empty string
        viewModel.filterCities(with: "")
        XCTAssertEqual(viewModel.filteredCityDetails, mockCityDetails)
    }

    // Test: Ensure selected city is updated correctly
    func testUpdateSelectedCity() {
        // Given
        let mockCityDetails = MockCityDetailsResponseModel().getCityDetailsResponseModel()
        
        // When
        viewModel.updateSelectedCity(cityDetails: mockCityDetails)
        
        XCTAssertTrue(mockUseCase.isUpdateCalled)
    }

    // Test: Ensure correct city name and country code formatting
    func testGetCityNameAndCountrycode() {
        // Given
        let mockCityDetails: [CityDetails] = MockCityDetailsResponseModel().getCityDetailsResponseModelArray()
        
        // When
        let formattedNameWithCountry = viewModel.getCityNameAndCountrycode(cityDetails: mockCityDetails[0])
        let formattedNameWithoutCountry = viewModel.getCityNameAndCountrycode(cityDetails: mockCityDetails[1])
        
        // Then
        XCTAssertEqual(formattedNameWithCountry, "Test City, IN")
        XCTAssertEqual(formattedNameWithoutCountry, "Test City1")
    }
}
