//
//  CityNames.swift
//  DiplomWork3 Weather
//
//  Created by Apple on 13.02.26.
//

final class CityNames: Codable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let localNames: String
    
    init(name: String, lat: Double, lon: Double, country: String, localNames: String) {
        self.name = name
        self.lat = lat
        self.lon = lon
        self.country = country
        self.localNames = localNames
    }
}
