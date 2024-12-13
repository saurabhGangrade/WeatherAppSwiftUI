//
//  WeatherForeCastViewModelTests.swift
//  WeatherAppSwiftUIUITests
//

import XCTest
import SwiftUI
@testable import WeatherAppSwiftUI

class WeatherForeCastViewModelTests: XCTestCase {
    
    var viewModel: WeatherForeCastViewModel!
    var mockUseCase: MockWeatherForeCastUseCase!
    var mockActions: WeatherForeCastViewModelActions!
    
    override func setUp() {
        super.setUp()
        // Setup mock use case and actions
        mockUseCase = MockWeatherForeCastUseCase()
        mockActions = WeatherForeCastViewModelActions(showLocationChangeScreen: { _ in
            self.mockUseCase.isActionCalled = true
            return EmptyView()
        })
        viewModel = WeatherForeCastViewModel(useCase: mockUseCase, actions: mockActions)
    }
    
    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        mockActions = nil
        super.tearDown()
    }
    
    // MARK: - Test fetchWeatherDetails
    
    func testFetchWeatherDetailsSuccess() {
        // Setup mock response
        mockUseCase.mockWeatherResponse = MockWeatherForeCastResponseModel().getWeatherForeCastResponseModel()
        viewModel.fetchWeatherDetails()
        XCTAssertFalse(self.viewModel.isLoading)
        XCTAssertFalse(self.viewModel.isCityNameNotFound)
        XCTAssertEqual(self.viewModel.getCityName(), "Test City")
        XCTAssertEqual(self.viewModel.getCurrentTemperature(index: 0), "25.0°C")
        
//        // Create an expectation for the async call
//        let expectation = self.expectation(description: "Weather details fetched successfully")
//        
//        // Call fetchWeatherDetails
//        viewModel.fetchWeatherDetails()
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            // Test that data is populated
//            XCTAssertFalse(self.viewModel.isLoading)
//            XCTAssertFalse(self.viewModel.isCityNameNotFound)
//            XCTAssertEqual(self.viewModel.getCityName(), "Test City")
//            XCTAssertEqual(self.viewModel.getCurrentTemperature(index: 0), "25.0°C")
//
//            // Fulfill the expectation to indicate the async call is complete
//            expectation.fulfill()
//        }
//        // Then: Wait for the expectation to be fulfilled within the timeout
//        wait(for: [expectation], timeout: 0.1)
    }
    
    func testFetchWeatherDetailsFailure() {
        // Setup mock to simulate failure
        mockUseCase.shouldReturnError = true
        
        // Call fetchWeatherDetails
        viewModel.fetchWeatherDetails()
        
        // Test error state
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.isCityNameNotFound)
        if let errorMessage = viewModel.errorMessage {
            XCTAssertEqual(errorMessage, Localizable.noWeatherData)
        } else {
            XCTFail("errorMessage nil.")
        }
    }
    
    func testFetchWeatherDetailsNoCityFound() {
        // Setup mock response with no city
        mockUseCase.isSelectedCityFound = false
        
        // Call fetchWeatherDetails
        viewModel.fetchWeatherDetails()
        
        // Test error state when city is not found
        if let errorMessage = viewModel.errorMessage {
            XCTAssertEqual(errorMessage, Localizable.noSelectedCity)
        } else {
            XCTFail("errorMessage nil.")
        }
        
        XCTAssertTrue(viewModel.isCityNameNotFound, "City name should not be found")
        XCTAssertFalse(viewModel.isLoading, "Loading should be stopped")

    }
    
    // MARK: - Test isCityModified
    
    func testIsCityModifiedWhenCityIsSame() {
        // Test when city names are the same
        mockUseCase.mockCityName = "Test City"
        mockUseCase.mockWeatherResponse = MockWeatherForeCastResponseModel().getWeatherForeCastResponseModel()
        viewModel.fetchWeatherDetails()
        XCTAssertFalse(self.viewModel.isCityModified())
        
//        // Create an expectation for the async call
//        let expectation = self.expectation(description: "Weather details fetched successfully")
//        
//        // Call fetchWeatherDetails
//        viewModel.fetchWeatherDetails()
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//
//            // The city name is the same, so it should return false
//            XCTAssertFalse(self.viewModel.isCityModified())
//            // Fulfill the expectation to indicate the async call is complete
//            expectation.fulfill()
//        }
//        // Then: Wait for the expectation to be fulfilled within the timeout
//        wait(for: [expectation], timeout: 0.1)
    }
    
    func testIsCityModifiedWhenCityIsDifferent() {
        // Test when the city names are different
        mockUseCase.mockCityName = "Different City"
        mockUseCase.mockWeatherResponse = MockWeatherForeCastResponseModel().getWeatherForeCastResponseModel()
        viewModel.fetchWeatherDetails()
        
        // The city name is different, so it should return true
        XCTAssertTrue(viewModel.isCityModified())
    }
    
    // MARK: - Test Show Location View
    
    func testShowLocationView() {
        let _ = viewModel.showLocationView(.constant(false))

        // Test that the location change screen was called
        XCTAssertTrue(mockUseCase.isActionCalled)
    }
    
    // MARK: - Test Data Access Methods
    
    func testGetCityName() {
        // Setup mock response
        mockUseCase.mockWeatherResponse = MockWeatherForeCastResponseModel().getWeatherForeCastResponseModel()
        viewModel.fetchWeatherDetails()
        
        XCTAssertEqual(viewModel.getCityName(), "Test City", "City name should be 'Test City'")
        
//        // Create an expectation for the async call
//        let expectation = self.expectation(description: "Weather details fetched successfully")
//        
//        // Call fetchWeatherDetails
//        viewModel.fetchWeatherDetails()
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            // Verify city name
//            XCTAssertEqual(self.viewModel.getCityName(), "Test City")
//            // Fulfill the expectation to indicate the async call is complete
//            expectation.fulfill()
//        }
//        // Then: Wait for the expectation to be fulfilled within the timeout
//        wait(for: [expectation], timeout: 0.1)
    }
    
    func testGetTemperatureType() {
        // Setup mock response
        mockUseCase.mockWeatherResponse = MockWeatherForeCastResponseModel().getWeatherForeCastResponseModel()
        viewModel.fetchWeatherDetails()
        
        // Verify temperature type
        XCTAssertEqual(viewModel.getTemperatureType(index: 0), "Clouds")
    }
    
    func testGetTemperatureTypeImage() {
        // Setup mock response
        mockUseCase.mockWeatherResponse = MockWeatherForeCastResponseModel().getWeatherForeCastResponseModel()
        viewModel.fetchWeatherDetails()
        
        // Verify temperature icon
        XCTAssertEqual(viewModel.getTemperatureTypeImage(index: 0), "04d")
    }
    
    func testGetMaxTemperature() {
        // Setup mock response
        mockUseCase.mockWeatherResponse = MockWeatherForeCastResponseModel().getWeatherForeCastResponseModel()
        viewModel.fetchWeatherDetails()
        
        // Verify max temperature
        XCTAssertEqual(viewModel.getMaxTemperature(index: 0), "30.0°C")
    }
    
    func testGetMinTemperature() {
        // Setup mock response
        mockUseCase.mockWeatherResponse = MockWeatherForeCastResponseModel().getWeatherForeCastResponseModel()
        viewModel.fetchWeatherDetails()
        
        // Verify min temperature
        XCTAssertEqual(viewModel.getMinTemperature(index: 0), "10.0°C")
    }
    
    // Test: Check data formatting for temperature
    func testGetFormattedTemperature() {
        // Setup mock response
        mockUseCase.mockWeatherResponse = MockWeatherForeCastResponseModel().getWeatherForeCastResponseModel()
        
        // Act: Call fetchWeatherDetails
        viewModel.fetchWeatherDetails()

        // Assert: Check if formatted temperature is correct
        XCTAssertEqual(viewModel.getCurrentTemperature(index: 0), "25.0°C", "Current temperature should be '23.0°C'")
        XCTAssertEqual(viewModel.getMaxTemperature(index: 0), "30.0°C", "Max temperature should be '27.0°C'")
        XCTAssertEqual(viewModel.getMinTemperature(index: 0), "10.0°C", "Min temperature should be '18.0°C'")
    }
    
    func testGetWeatherDetailsForFullDay() {
        // Setup mock response
        mockUseCase.mockWeatherResponse = MockWeatherForeCastResponseModel().getWeatherForeCastResponseModel()
        
        // Act: Call fetchWeatherDetails
        viewModel.fetchWeatherDetails()
        
        let weatherForeCastDetails: [WeatherForeCastDetails] = viewModel.getWeatherDetailsForFullDay(day: 0)
        
        // Then: Check that the correct weather details are returned for the first day (index 0)
        XCTAssertEqual(weatherForeCastDetails.count, 1, "There should be 1 weather detail for the first day.")
        XCTAssertEqual(weatherForeCastDetails.first?.temperature, "25.0", "The temperature for the first day should be 25°C.")
        XCTAssertEqual(weatherForeCastDetails.first?.weatherType, "Clouds", "The weather type for the first day should be Clouds.")
    }
    
    func testGetWeatherDetailsForFullDayInvalidIndex() {
        // Setup mock response
        mockUseCase.mockWeatherResponse = MockWeatherForeCastResponseModel().getWeatherForeCastResponseModel()
        
        // Act: Call fetchWeatherDetails
        viewModel.fetchWeatherDetails()
        
        let weatherForeCastDetails: [WeatherForeCastDetails] = viewModel.getWeatherDetailsForFullDay(day: 2)
        
        // Then: The method should return an empty array because the index is out of range
        XCTAssertTrue(weatherForeCastDetails.isEmpty, "Weather details should be empty for an out-of-range index.")
    }
    
    func testGetTodaysDayFirstDay() {
        // Setup mock response
        mockUseCase.mockWeatherResponse = MockWeatherForeCastResponseModel().getWeatherForeCastResponseModel()
        
        // Act: Call fetchWeatherDetails
        viewModel.fetchWeatherDetails()
        
        // When: Call the method with the first index (0)
        let day = viewModel.getTodaysDay(index: 0)
        
        // Then: It should return "Today" for the first entry
        XCTAssertEqual(day, "Today", "The day for the first entry should be 'Today'.")
    }
    
    func testGetTodaysDaySubsequentDay() {
        // Setup mock response
        mockUseCase.mockWeatherResponse = MockWeatherForeCastResponseModel().getWeatherForeCastResponseModel()
        
        // Act: Call fetchWeatherDetails
        viewModel.fetchWeatherDetails()
        
        // When: Call the method with a valid index for the second day (index 1)
        let day = viewModel.getTodaysDay(index: 1)
        
        // Then: It should return the correct day name for the second entry ("Tuesday")
        XCTAssertEqual(day, "Friday", "The day for the second entry should be 'Friday'.")
    }
    
    func testGetTodaysDayInvalidIndex() {
        // Setup mock response
        mockUseCase.mockWeatherResponse = MockWeatherForeCastResponseModel().getWeatherForeCastResponseModel()
        
        // Act: Call fetchWeatherDetails
        viewModel.fetchWeatherDetails()
        
        // When: Call the method with an invalid index (out of bounds, e.g., index 2)
        let day = viewModel.getTodaysDay(index: 2)
        
        // Then: It should return an empty string since the index is out of bounds
        XCTAssertEqual(day, "", "The method should return an empty string for an out-of-bounds index.")
    }
    
    func testGetTodaysDateFirstDay() {
        // Setup mock response
        mockUseCase.mockWeatherResponse = MockWeatherForeCastResponseModel().getWeatherForeCastResponseModel()
        
        // Act: Call fetchWeatherDetails
        viewModel.fetchWeatherDetails()
        
        // When: Call the method with the first index (0)
        let date = viewModel.getTodaysDate(index: 0)
        
        // Then: It should return "Today 2024-12-12" for the first entry
        XCTAssertEqual(date, "Today Thursday, 12 Dec 2024", "The date for the first entry should be 'Today Thursday, 12 Dec 2024'.")
    }
    
    func testGetTodaysDateSubsequentDay() {
        // Setup mock response
        mockUseCase.mockWeatherResponse = MockWeatherForeCastResponseModel().getWeatherForeCastResponseModel()
        
        // Act: Call fetchWeatherDetails
        viewModel.fetchWeatherDetails()
        
        // When: Call the method with a valid index for the second day (index 1)
        let date = viewModel.getTodaysDate(index: 1)
        
        // Then: It should return "Today 2024-12-13" for the second entry
        XCTAssertEqual(date, "Today Friday, 13 Dec 2024", "The date for the second entry should be 'Today Friday, 13 Dec 2024'.")
    }
    
    func testGetTodaysDateInvalidIndex() {
        // Setup mock response
        mockUseCase.mockWeatherResponse = MockWeatherForeCastResponseModel().getWeatherForeCastResponseModel()
        
        // Act: Call fetchWeatherDetails
        viewModel.fetchWeatherDetails()
        
        // When: Call the method with an invalid index (out of bounds, e.g., index 2)
        let date = viewModel.getTodaysDate(index: 2)
        
        // Then: It should return an empty string since the index is out of bounds
        XCTAssertEqual(date, "", "The method should return an empty string for an out-of-bounds index.")
    }
    
    func testGetDayCountWithValidData() {
        // Setup mock response
        mockUseCase.mockWeatherResponse = MockWeatherForeCastResponseModel().getWeatherForeCastResponseModel()
        
        // Act: Call fetchWeatherDetails
        viewModel.fetchWeatherDetails()
        
        // When: Call the getDayCount method
        let dayCount = viewModel.getDayCount()
        
        // Then: It should return the correct number of days (in this case, 2)
        XCTAssertEqual(dayCount, 2, "The day count should be 2.")
    }
    
    func testGetDayCountWithNoData() {
        // Setup mock response
        mockUseCase.mockWeatherResponse = MockWeatherForeCastResponseModel().getWeatherForeCastResponseModelWithNoWeatherData()
        
        // Act: Call fetchWeatherDetails
        viewModel.fetchWeatherDetails()
        
        // When: Call the getDayCount method
        let dayCount = viewModel.getDayCount()
        
        // Then: It should return 0 since there is no forecast data
        XCTAssertEqual(dayCount, 0, "The day count should be 0 when there is no forecast data.")
    }
    
    func testGetDayCountWithNilData() {
        // Setup mock response
        mockUseCase.mockWeatherResponse = nil
        
        // Act: Call fetchWeatherDetails
        viewModel.fetchWeatherDetails()
        
        // When: Call the getDayCount method
        let dayCount = viewModel.getDayCount()
        
        // Then: It should return 0 since WeatherForeCastByDate is nil
        XCTAssertEqual(dayCount, 0, "The day count should be 0 when WeatherForeCastByDate is nil.")
    }
    
    func testShowLoaderAndResetErrorMessage() {
        // Given: Initial state of the view model
        viewModel.isLoading = false
        viewModel.errorMessage = "Some error occurred"
        
        // When: Call the showLoaderAndResetErrorMessage method
        viewModel.showLoaderAndRestetErrorMessage()
        
        // Then: Assert that isLoading is set to true
        XCTAssertTrue(viewModel.isLoading, "The isLoading property should be set to true.")
        
        // Then: Assert that errorMessage is reset to nil
        XCTAssertNil(viewModel.errorMessage, "The errorMessage property should be reset to nil.")
    }
    
    func testGetCityNameWithValidCity() {
        // Setup mock response
        mockUseCase.mockWeatherResponse = MockWeatherForeCastResponseModel().getWeatherForeCastResponseModel()
        
        // Act: Call fetchWeatherDetails
        viewModel.fetchWeatherDetails()
        
        // When: Call the getCityName method
        let cityName = viewModel.getCityName()
        
        // Then: It should return the correct city name
        XCTAssertEqual(cityName, "Test City", "The city name should be 'Test City'.")
    }
    
    func testGetCityNameWithNoCity() {
        // Setup mock response
        mockUseCase.mockWeatherResponse = MockWeatherForeCastResponseModel().getWeatherForeCastResponseModelWithNoCity()
        
        // Act: Call fetchWeatherDetails
        viewModel.fetchWeatherDetails()
        
        // When: Call the getCityName method
        let cityName = viewModel.getCityName()
        
        // Then: It should return an empty string when the city name is not provided
        XCTAssertEqual(cityName, "", "The city name should be an empty string when no city is provided.")
    }
    
    func testGetCityNameWithNilWeatherDetails() {
        // Given: Prepare the mock data with nil weather details
        mockUseCase.mockWeatherResponse = nil // Simulate no weather data
        viewModel.fetchWeatherDetails()
        
        // When: Call the getCityName method
        let cityName = viewModel.getCityName()
        
        // Then: It should return an empty string when weatherDetailsModel is nil
        XCTAssertEqual(cityName, "", "The city name should be an empty string when weatherDetailsModel is nil.")
    }
    
    func testGetMinTemperatureWithNilWeatherDetails() {
        // Given: Prepare the mock data with nil weather forecast data
        mockUseCase.mockWeatherResponse = nil // Simulating no weather data
        viewModel.fetchWeatherDetails()
        
        // When: Call the getMinTemperature method with a valid index (0)
        let minTemp = viewModel.getMinTemperature(index: 0)
        
        // Then: It should return an empty string since weatherDetailsModel is nil
        XCTAssertEqual(minTemp, "", "The minimum temperature should be an empty string when weatherDetailsModel is nil.")
    }
    
    func testGetTemperatureTypeWithNilWeatherDetails() {
        // Given: Prepare the mock data with nil weather forecast data
        mockUseCase.mockWeatherResponse = nil // Simulating no weather data
        viewModel.fetchWeatherDetails()
        
        // When: Call the getTemperatureType method with a valid index (0)
        let temperatureType = viewModel.getTemperatureType(index: 0)
        
        // Then: It should return an empty string since weatherDetailsModel is nil
        XCTAssertEqual(temperatureType, "", "The temperature type should be an empty string when weatherDetailsModel is nil.")
    }
    
    func testGetTemperatureTypeImageWithNilWeatherDetails() {
        // Given: Prepare the mock data with nil weather forecast data
        mockUseCase.mockWeatherResponse = nil // Simulating no weather data
        viewModel.fetchWeatherDetails()
        
        // When: Call the getTemperatureTypeImage method with a valid index (0)
        let temperatureTypeImage = viewModel.getTemperatureTypeImage(index: 0)
        
        // Then: It should return an empty string since weatherDetailsModel is nil
        XCTAssertEqual(temperatureTypeImage, "", "The temperature type image should be an empty string when weatherDetailsModel is nil.")
    }
        
    func testGetCurrentTemperatureWithNilWeatherDetails() {
        // Given: Prepare the mock data with nil weather forecast data
        mockUseCase.mockWeatherResponse = nil // Simulating no weather data
        viewModel.fetchWeatherDetails()
        
        // When: Call the getCurrentTemperature method with a valid index (0)
        let currentTemperature = viewModel.getCurrentTemperature(index: 0)
        
        // Then: It should return an empty string since weatherDetailsModel is nil
        XCTAssertEqual(currentTemperature, "", "The current temperature should be an empty string when weatherDetailsModel is nil.")
    }
    
    func testGetMaxTemperatureWithNilWeatherDetails() {
        // Given: Prepare the mock data with nil weather forecast data
        mockUseCase.mockWeatherResponse = nil // Simulating no weather data
        viewModel.fetchWeatherDetails()
        
        // When: Call the getMaxTemperature method with a valid index (0)
        let maxTemperature = viewModel.getMaxTemperature(index: 0)
        
        // Then: It should return an empty string since weatherDetailsModel is nil
        XCTAssertEqual(maxTemperature, "", "The max temperature should be an empty string when weatherDetailsModel is nil.")
    }
    
    func testFetchWeatherDetailsFailureGenericError() {
        // Given: Prepare a mock response for failure with a generic error
        mockUseCase.mockWeatherResponse = nil // Simulating no weather data
        
        // When: Call the fetchWeatherDetails method
        viewModel.fetchWeatherDetails()
        
        // Then: Verify that the errorMessage is set to "An error occurred while fetching weather data."
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after handling error.")
        XCTAssertEqual(viewModel.errorMessage, Localizable.errorWhileFetching, "Error message should be 'An error occurred while fetching weather data.'")
    }
}
