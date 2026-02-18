//
//  Coordinates.swift
//  DiplomWork3 Weather
//
//  Created by Apple on 28.01.26.
//

final class Coordinates {
    var lat: Double
    var lon: Double
    
    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
    
    func changeCoordinates(latitude: Double, longtitude: Double){
        self.lat = latitude
        self.lon = longtitude
    }
}
