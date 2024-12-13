//
//  CityResponseModel.swift
//  WeatherApp


import Foundation

// MARK: - Response
struct CityDetails: Codable, Identifiable, Hashable {
    static func == (lhs: CityDetails, rhs: CityDetails) -> Bool {
        return true
    }
    
    var id = UUID()
    let cityName: String
    let coord: Coord
    let cityCountryCode: String?
    let cityStateName: String?
    
    enum CodingKeys: String, CodingKey {
        case cityName = "name"
        case coord = "coord"
        case cityCountryCode = "country"
        case cityStateName = "state"
    }
}

struct Coord: Codable, Hashable {
    let cityLatitude: Double
    let cityLongitude: Double

    enum CodingKeys: String, CodingKey {
        case cityLatitude = "lat"
        case cityLongitude = "lon"
    }
}
