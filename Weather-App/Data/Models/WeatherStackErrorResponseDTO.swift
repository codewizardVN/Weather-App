//
//  WeatherStackErrorResponseDTO.swift
//  Weather-App
//
//  Created by Kobe on 23/3/26.
//

import Foundation

struct WeatherStackErrorResponseDTO: Decodable {
    let success: Bool?
    let error: WeatherStackErrorDTO?
    
    struct WeatherStackErrorDTO: Decodable {
        let code: Int
        let type: String
        let info: String
    }
}
