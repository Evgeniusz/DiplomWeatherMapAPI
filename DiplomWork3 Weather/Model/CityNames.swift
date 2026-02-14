//
//  CityNames.swift
//  DiplomWork3 Weather
//
//  Created by Apple on 13.02.26.
//

final class CityNames {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    
    init(name: String, lat: Double, lon: Double, country: String) {
        self.name = name
        self.lat = lat
        self.lon = lon
        self.country = country
    }
}
