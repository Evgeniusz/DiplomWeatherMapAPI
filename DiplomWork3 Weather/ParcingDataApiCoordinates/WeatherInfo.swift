//
//  WeatherInfo.swift
//  DiplomWork3 Weather
//
//  Created by Apple on 6.02.26.
//
import Foundation

final class WeatherInfo: Decodable {
    var description: String?
    var icon: String?
    
    init(description: String? = nil, icon: String? = nil) {
        self.description = description
        self.icon = icon
    }
}
