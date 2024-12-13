//
//  MockCityDetailsResponseModel.swift
//  WeatherAppSwiftUI
//

class MockCityDetailsResponseModel {
    
    func getCityDetailsResponseModel() -> CityDetails {
        return getCityDetailsResponseModelArray().first!
    }
    
    func getCityDetailsWithoutName() -> CityDetails {
        let cityDetailsResponseModel = CityDetails(cityName: "",
                                                   coord: Coord(cityLatitude: 1.12,
                                                                cityLongitude: 2.31),
                                                   cityCountryCode: "",
                                                   cityStateName: "")
        return cityDetailsResponseModel
    }
    
    func getCityDetailsResponseModelArray() -> [CityDetails] {
        let cityDetailsResponseModel = CityDetails(cityName: "Test City",
                                                   coord: Coord(cityLatitude: 1.12,
                                                                cityLongitude: 2.31),
                                                   cityCountryCode: "IN",
                                                   cityStateName: "")
        
        let cityDetailsResponseModel1 = CityDetails(cityName: "Test City1",
                                                   coord: Coord(cityLatitude: 1.12,
                                                                cityLongitude: 2.31),
                                                    cityCountryCode: nil,
                                                   cityStateName: "")
        
        let cityDetailsResponseModel2 = CityDetails(cityName: "Est City2",
                                                   coord: Coord(cityLatitude: 1.12,
                                                                cityLongitude: 2.31),
                                                   cityCountryCode: "IN",
                                                   cityStateName: "")
        return [cityDetailsResponseModel, cityDetailsResponseModel1, cityDetailsResponseModel2]
    }
}
