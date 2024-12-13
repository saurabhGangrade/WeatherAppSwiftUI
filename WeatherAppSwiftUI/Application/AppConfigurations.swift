//
//  AppConfiguration.swift
//  WeatherApp


import Foundation

final class AppConfiguration {
    static let shared = AppConfiguration()
    private init() {}

    lazy var apiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: Constants.API.apiKey) as? String else {
            return Constants.API.apiKeyValue
        }
        return apiKey
    }()

    lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: Constants.API.apiBaseURL) as? String else {
            return Constants.API.apiBaseURLValue
        }
        return apiBaseURL
    }()
}
