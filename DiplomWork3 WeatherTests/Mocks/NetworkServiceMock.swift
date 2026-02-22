//
//  NetworkServiceMock.swift
//  DiplomWork3 Weather
//
//  Created by Apple on 20.02.26.
//
@testable import DiplomWork3_Weather

final class NetworkServiceMock: iNetworkService {
    
    // first func cityRequest() which request currentSityRequest()
    var invokedGetCoordinates = false
    var invokedGetCoordinatesCount = 0
    var invokedGetJSON: MainParsing?
    
    //second func find city request
    var invokedFindCityRequest = false
    var invokedFindCityRequestCount = 0
    var someCity = "Braslav"
    
    //third func coordinatesCityRequest
    var invokedCoordinatesCityRequest = false
    var invokedCoordinatesCityRequestCount = 0
    var invokedCoordinates = Coordinates(lat: 20, lon: 20)
    var invokedCoordinatesBool = false
    
    //first uint
    func currentCityRequest(complition: @escaping (MainParsing) -> Void) {
        invokedGetCoordinates = true
        invokedGetCoordinatesCount += 1
    }
    
    //third unit
    func coordinatesCityRequest(coordinates: Coordinates, complition: @escaping (MainParsing) -> Void) {
        invokedCoordinatesCityRequest = true
        invokedCoordinatesCityRequestCount += 1
        if coordinates.lat == invokedCoordinates.lat && coordinates.lon == invokedCoordinates.lon{
            invokedCoordinatesBool = true
        }
    }
    //second unit
    func cityRequest(text: String, complition: @escaping ([CityNames]) -> Void) {
        someCity = text
        invokedFindCityRequest = true
        invokedFindCityRequestCount += 1
    }
    
}

