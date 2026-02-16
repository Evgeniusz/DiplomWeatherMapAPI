//
//  SaveLoadManager.swift
//  DiplomWork3 Weather
//
//  Created by Apple on 15.02.26.
//
import UIKit

enum Keys: String {
    case arrayCity
}

final class SaveLoadManager {
    private let manager = UserDefaults.standard
    
    func saveArrayCity (_ array: [CityNames]) {
        manager.set(encodable: array, for: Keys.arrayCity.rawValue)
    }
    
    func loadArrayCity () -> [CityNames]? {
        manager.get(decodable: [CityNames].self, for: Keys.arrayCity.rawValue)
    }
}
