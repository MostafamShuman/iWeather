//
//  City.swift
//  iWeather
//
//  Created by Mostafa Shuman on 29/01/2022.
//

import Foundation

struct City: Codable {
    let title: String?
    let woeid: Int?
    let time: String?
    let sunRise: String?
    let sunSet: String?
    let timezoneName: String?
    let consolidatedWeather: [ConsolidatedWeather]?
    
    enum CodingKeys: String, CodingKey {
        case title, woeid, time
        case sunRise = "sun_rise"
        case sunSet = "sun_set"
        case timezoneName = "timezone_name"
        case consolidatedWeather = "consolidated_weather"
    }
}

struct ConsolidatedWeather: Codable {
    let id: Double?
    let weatherStateName: String?
    let weatherStateAbbr: String?
    let windDirectionCompass: String?
    let applicableDate: String?
    let minTemp: Double?
    let maxTemp: Double?
    let theTemp: Double?
    let windSpeed: Double?
    let windDirection: Double?
    let airPressure: Double?
    let humidity: Double?
    let visibility: Double?
    let predictability: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, humidity, visibility, predictability
        case weatherStateName = "weather_state_name"
        case weatherStateAbbr = "weather_state_abbr"
        case windDirectionCompass = "wind_direction_compass"
        case applicableDate = "applicable_date"
        case minTemp = "min_temp"
        case maxTemp = "max_temp"
        case theTemp = "the_temp"
        case windSpeed = "wind_speed"
        case windDirection = "wind_direction"
        case airPressure = "air_pressure"
    }
}
