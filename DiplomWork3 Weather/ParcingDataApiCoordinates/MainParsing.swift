//
//  MainParsing.swift
//  DiplomWork3 Weather
//
//  Created by Apple on 6.02.26.
//

import Foundation

final class MainParsing: Decodable {
    var latitude: Double?
    var longtitude: Double?
    var timeZone: String?
    var current: CurrentInfo?
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longtitude = "lon"
        case timeZone = "timezone"
        case current
    }
    
    init(latitude: Double? = nil, longtitude: Double? = nil, timeZone: String? = nil, current: CurrentInfo? = nil) {
        self.latitude = latitude
        self.longtitude = longtitude
        self.timeZone = timeZone
        self.current = current
    }
}
