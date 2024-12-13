//
//  APIEndpoints.swift
//  WeatherApp


import Foundation

struct APIEndpoints {
//    api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}&appid={API key}
//https://api.openweathermap.org/geo/1.0/direct?q=London&limit=5&appid=e206964953e91711c358cfdfa06b6f39

    static func requestForWeatherDetailsAPI(with requestDTO: [String: String], isGetRequest: Bool) -> Endpoint<WeatherForeCastResponseModel> {
        return Endpoint(path: Constants.API.gatewayPath,
                        method: isGetRequest ? .get : .post,
                        queryParameters: requestDTO)
    }
}
