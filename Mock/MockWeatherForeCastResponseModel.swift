//
//  Untitled.swift
//  WeatherAppSwiftUI
//

class MockWeatherForeCastResponseModel {
    func getWeatherForeCastResponseModel() -> WeatherForeCastResponseModel {
        let weatherTemperatureDetails = WeatherTemperatureDetails(temperature: 25,
                                                                  temperatureMin: 10,
                                                                  temperatureMax: 30)
        let weatherDetails = WeatherDetails(weatherType: "Clouds",
                                            weatherIcon: "04d")
        let weatherForeCastDetails = WeatherForeCastDetails(dateInt: 1733994000,
                                                            weatherTemperatureDetails: weatherTemperatureDetails,
                                                            weatherDetails: [weatherDetails])
        
        let weatherForeCastDetails1 = WeatherForeCastDetails(dateInt: 1734084000,
                                                            weatherTemperatureDetails: weatherTemperatureDetails,
                                                            weatherDetails: [weatherDetails])
        
        let weatherResponse = WeatherForeCastResponseModel(weatherList: [weatherForeCastDetails, weatherForeCastDetails1],
                                                           cityDetails: MockCityDetailsResponseModel().getCityDetailsResponseModel())
        return weatherResponse
    }
    
    func getWeatherForeCastResponseModelWithNoWeatherData() -> WeatherForeCastResponseModel {
        let weatherResponse = WeatherForeCastResponseModel(weatherList: [],
                                                           cityDetails: MockCityDetailsResponseModel().getCityDetailsResponseModel())
        return weatherResponse
    }
    
    func getWeatherForeCastResponseModelWithNoCity() -> WeatherForeCastResponseModel {
        let weatherResponse = WeatherForeCastResponseModel(weatherList: [],
                                                           cityDetails: MockCityDetailsResponseModel().getCityDetailsWithoutName())
        return weatherResponse
    }
}
