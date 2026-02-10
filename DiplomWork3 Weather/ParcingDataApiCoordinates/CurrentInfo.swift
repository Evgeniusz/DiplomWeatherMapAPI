//
//  CurrentInfo.swift
//  DiplomWork3 Weather
//
//  Created by Apple on 6.02.26.
//

import Foundation

final class CurrentInfo: Decodable {
    var temp: Double?
    var feelsLike: Double?
    var pressure: Int?
    var windSpeed: Double?
    var windDegrees: Int?
    var weather: [WeatherInfo]?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case pressure
        case windSpeed = "wind_speed"
        case windDegrees = "wind_deg"
        case weather
    }
    
    init(temp: Double? = nil, feelsLike: Double? = nil, pressure: Int? = nil, windSpeed: Double? = nil, windDegrees: Int? = nil, weather: [WeatherInfo]? = nil) {
        self.temp = temp
        self.feelsLike = feelsLike
        self.pressure = pressure
        self.windSpeed = windSpeed
        self.windDegrees = windDegrees
        self.weather = weather
    }
}
