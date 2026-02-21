//
//  NetworkServiceStub.swift
//  DiplomWork3 Weather
//
//  Created by Apple on 20.02.26.
//

@testable import DiplomWork3_Weather

final class NetworkServiceStub: iNetworkService {
    func currentCityRequest(complition: @escaping (DiplomWork3_Weather.MainParsing) -> Void) {}
    
    func coordinatesCityRequest(coordinates: DiplomWork3_Weather.Coordinates, complition: @escaping (DiplomWork3_Weather.MainParsing) -> Void) {}
    
    func cityRequest(text: String, complition: @escaping ([DiplomWork3_Weather.CityNames]) -> Void) {}
    
}
