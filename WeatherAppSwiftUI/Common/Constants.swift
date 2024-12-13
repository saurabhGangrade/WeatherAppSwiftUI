//
//  Constants.swift
//  WeatherAppSwiftUI
//


struct Constants {
    
    struct API {
        static let apiKey: String = "ApiKey"
        static let apiKeyValue: String = "e206964953e91711c358cfdfa06b6f39"
        
        static let apiBaseURL: String = "ApiBaseURL"
        static let apiBaseURLValue: String = "https://api.openweathermap.org"
        
        static let gatewayPath = "data/2.5/forecast"
    }
    
    struct WeatherReportParam {
        static let lat = "lat"
        static let lon = "lon"
        static let appid = "appid"
        static let units = "units"
    }
    
    struct WeatherReportParamValue {
        static let units = "metric"
    }
    
    struct DateUtils {
        static let longDateFormat = "EEEE, dd MMM yyyy"
        static let dayFormat = "EEEE"
        static let shortTimeFormat = "ha"
    }
    
    struct Resources {
        static let cityList: String = "city_list"
        static let extensionJSON: String = "json"
        
        static let locationImage: String = "location"
        static let defaultWeatherIcon: String = "defaultWeatherIcon"
        static let weatherBGImage: String = "weatherBG"
        
        
    }
}
