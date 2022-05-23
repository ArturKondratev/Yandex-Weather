//
//  WeatherData.swift
//  YandexWeather
//
//  Created by Артур Кондратьев on 17.03.2022.
//

import Foundation

struct WeatherData: Decodable {
    
    let info: Info
    let fact: Fact
    let forecasts: [Forecast]
}

struct Info: Decodable {
    let url: String
}

struct Fact: Decodable {
    
    let temp: Double
    let feels_like: Double
    let icon: String
    let condition: String
    let windSpeed: Double
    let pressureMm: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feels_like
        case icon
        case condition
        case windSpeed = "wind_speed"
        case pressureMm = "pressure_mm"
    }
}

struct Forecast: Decodable {
    let parts: Parts
}

struct Parts: Decodable {
    let day: Hour
}

struct Hour: Decodable {
    let tempMin: Int?
    let tempMax: Int?
    
    enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}
