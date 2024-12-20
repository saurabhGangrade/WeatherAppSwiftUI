//
//  WeatherForeCastResponseModel.swift
//  WeatherApp


import Foundation

// MARK: - Response
struct WeatherForeCastResponseModel: Codable, Hashable {
    static func == (lhs: WeatherForeCastResponseModel, rhs: WeatherForeCastResponseModel) -> Bool {
        return true
    }
    
    let weatherList: [WeatherForeCastDetails]?
    let cityDetails: CityDetails?
    
    enum CodingKeys: String, CodingKey {
        case weatherList = "list"
        case cityDetails = "city"
    }
}

struct WeatherForeCastDetails: Codable, Hashable {
    static func == (lhs: WeatherForeCastDetails, rhs: WeatherForeCastDetails) -> Bool {
        return true
    }
    
    let dateInt: Int
    let weatherTemperatureDetails: WeatherTemperatureDetails?
    let weatherDetails: [WeatherDetails]?
    
    enum CodingKeys: String, CodingKey {
        case dateInt = "dt"
        case weatherTemperatureDetails = "main"
        case weatherDetails = "weather"
    }

    var dateTime: Date {
        // convert Int to TimeInterval (typealias for Double)
        let timeInterval = TimeInterval(dateInt)

        // create & return NSDate from Double (NSTimeInterval)
        return Date(timeIntervalSince1970: timeInterval)
    }

    var date: String {
        // Formatted date
        return dateTime.getLongDate()
    }

    var day: String {
        // Formatted date
        return dateTime.getDay()
    }

    var time: String {
        // Formatted date
        return dateTime.getShortTime()
    }

    var temperature: String {
        guard let weatherTemperatureDetails = weatherTemperatureDetails else { return "" }
        return "\(weatherTemperatureDetails.temperature ?? 0.0)"
    }

    var temperatureMax: String {
        guard let weatherTemperatureDetails = weatherTemperatureDetails else { return "" }
        return "\(weatherTemperatureDetails.temperatureMax ?? 0.0)"
    }

    var temperatureMin: String {
        guard let weatherTemperatureDetails = weatherTemperatureDetails else { return "" }
        return "\(weatherTemperatureDetails.temperatureMin ?? 0.0)"
    }

    var weatherIcon: String {
        guard let weatherDetails = weatherDetails,
              weatherDetails.count > 0,
              let weatherIcon = weatherDetails[0].weatherIcon else { return "" }
        return weatherIcon
    }

    var weatherType: String {
        guard let weatherDetails = weatherDetails,
              weatherDetails.count > 0,
              let weatherType = weatherDetails[0].weatherType else { return "" }
        return weatherType
    }
}

// MARK: - WeatherTemperatureDetails
struct WeatherTemperatureDetails: Codable, Hashable {
    let temperature, temperatureMin, temperatureMax: Double?
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
}

// MARK: - WeatherDetails
struct WeatherDetails: Codable, Hashable {
    let weatherType, weatherIcon: String?
    
    enum CodingKeys: String, CodingKey {
        case weatherType = "main"
        case weatherIcon = "icon"
    }
}

struct WeatherForeCastDisplayModel {
    let WeatherForeCastByDate: [WeatherForeCastByDate]
    let cityName: String
}

struct WeatherForeCastByDate {
    let dateTime: Date
    var weatherForeCastDetails: [WeatherForeCastDetails]?

    var date: String {
        guard let weatherForeCastDetails = weatherForeCastDetails,
              weatherForeCastDetails.count > 0 else {
            return ""
        }
        return weatherForeCastDetails[0].date
    }

    var day: String {
        guard let weatherForeCastDetails = weatherForeCastDetails,
              weatherForeCastDetails.count > 0 else {
            return ""
        }
        return weatherForeCastDetails[0].day
    }

    var weatherIcon: String {
        guard let weatherForeCastDetails = weatherForeCastDetails,
              weatherForeCastDetails.count > 0 else {
            return Constants.Resources.defaultWeatherIcon
        }
        return weatherForeCastDetails[0].weatherIcon
    }

    var weatherType: String {
        guard let weatherForeCastDetails = weatherForeCastDetails,
              weatherForeCastDetails.count > 0 else {
            return ""
        }
        return weatherForeCastDetails[0].weatherType
    }

    var temperature: String {
        guard let weatherForeCastDetails = weatherForeCastDetails,
              weatherForeCastDetails.count > 0 else {
            return ""
        }
        return weatherForeCastDetails[0].temperature
    }

    var temperatureMax: String {
        guard let weatherForeCastDetails = weatherForeCastDetails,
              let maxTemperature = (weatherForeCastDetails.map{$0.temperatureMax}).max() else {
            return ""
        }
        return maxTemperature
    }

    var temperatureMin: String {
        guard let weatherForeCastDetails = weatherForeCastDetails,
              let minTemperature = (weatherForeCastDetails.map{$0.temperatureMin}).min() else {
            return ""
        }
        return minTemperature
    }
}
