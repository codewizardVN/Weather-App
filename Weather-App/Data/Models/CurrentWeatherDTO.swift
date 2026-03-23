//
//  CurrentWeatherDTO.swift
//  Weather-App
//
//  Created by Kobe on 21/3/26.
//

import Foundation

struct CurrentWeatherDTO: Decodable {
    let observationTime: String
    let temperature: Double
    let weatherCode: Int
    let weatherIcons: [String]
    let weatherDescriptions: [String]
    let windSpeed: Double
    let windDegree: Int
    let windDir: String
    let pressure: Int
    let precip: Double
    let humidity: Int
    let cloudcover: Int
    let feelslike: Double
    let uvIndex: Int
    let visibility: Int
    let isDay: String

    enum CodingKeys: String, CodingKey {
        case observationTime = "observation_time"
        case temperature
        case weatherCode = "weather_code"
        case weatherIcons = "weather_icons"
        case weatherDescriptions = "weather_descriptions"
        case windSpeed = "wind_speed"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressure
        case precip
        case humidity
        case cloudcover
        case feelslike
        case uvIndex = "uv_index"
        case visibility
        case isDay = "is_day"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        observationTime = try container.decode(String.self, forKey: .observationTime)
        temperature = try container.decodeFlexibleDouble(forKey: .temperature)
        weatherCode = try container.decodeFlexibleInt(forKey: .weatherCode)
        weatherIcons = try container.decode([String].self, forKey: .weatherIcons)
        weatherDescriptions = try container.decode([String].self, forKey: .weatherDescriptions)
        windSpeed = try container.decodeFlexibleDouble(forKey: .windSpeed)
        windDegree = try container.decodeFlexibleInt(forKey: .windDegree)
        windDir = try container.decode(String.self, forKey: .windDir)
        pressure = try container.decodeFlexibleInt(forKey: .pressure)
        precip = try container.decodeFlexibleDouble(forKey: .precip)
        humidity = try container.decodeFlexibleInt(forKey: .humidity)
        cloudcover = try container.decodeFlexibleInt(forKey: .cloudcover)
        feelslike = try container.decodeFlexibleDouble(forKey: .feelslike)
        uvIndex = try container.decodeFlexibleInt(forKey: .uvIndex)
        visibility = try container.decodeFlexibleInt(forKey: .visibility)
        isDay = try container.decode(String.self, forKey: .isDay)
    }
}
