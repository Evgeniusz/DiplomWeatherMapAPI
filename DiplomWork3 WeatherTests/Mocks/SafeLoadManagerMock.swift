//
//  SafeLoadManagerMock.swift
//  DiplomWork3 Weather
//
//  Created by Apple on 21.02.26.
//

@testable import DiplomWork3_Weather

final class SafeLoadManagerMock: ISafeLoadManager {
    
    var savedMockArray: [CityNames]?
    var addedAndSaved = false
    var count = 0
    
    func saveArrayCity(_ array: [CityNames]) {
        count += 1
        savedMockArray = array
        if let array = savedMockArray {
            if array.count > 0 {
                addedAndSaved = true
            }
        }
    }
    
    func loadArrayCity() -> [CityNames]? {
        let object = CityNames(name: "Guantanamo", lat: 20.145, lon: -75.206, country: "CU", localNames: "Guantánamo")
        savedMockArray = [CityNames]()
        savedMockArray?.append(object)
        addedAndSaved = true
        count += 1
        return savedMockArray
    }
    
}
