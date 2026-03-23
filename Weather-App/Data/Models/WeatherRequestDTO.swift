//
//  WeatherRequestDTO.swift
//  Weather-App
//
//  Created by Kobe on 21/3/26.
//

import Foundation

struct WeatherRequestDTO: Decodable {
    let type: String
    let query: String
    let language: String
    let unit: String
}
