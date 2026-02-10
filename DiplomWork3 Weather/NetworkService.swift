//
//  NetworkService.swift
//  DiplomWork3 Weather
//
//  Created by Apple on 28.01.26.
//

import Foundation
import SwiftyJSON
import CoreLocation

protocol iNetworkService {
    func cityRequest(complition: @escaping (MainParsing) -> Void)
}

enum Languages: String {
    case Russian = "ru"
    case English = "en"
    case Belarus = "be"
}

enum RequestType: String {
    case GET
    case POST
}

enum EndPoints: String {
    case baseURlCity = "geo/1.0/direct?q="
    case baseURLCoordinates = "data/3.0/onecall"
}

//enum Request

final class NetworkService: iNetworkService {
    let locationManager = LocationManager.shared
    
    var coordinates = Coordinates(lat: 51.5073219, lon: -0.1276474)
    let siteURL: String = "https://api.openweathermap.org/"
    var coordinatesURL: String { return "?lon=\(coordinates.lon)&lat=\(coordinates.lat)&units=\(units)&exclude=minutely,hourly,daily,alerts"}
    let apiKey: String = "&appid=713aa71dc84d2ca8a2ef48566162"
    let units: String = "metric ba05"
    var lanuage: Languages = .Belarus
    
    func cityRequest(complition: @escaping (MainParsing) -> Void){
        sendRequestWithCoordinates(requestType: .GET, endpoints: .baseURLCoordinates , key: apiKey) { data in
            guard let data else {return}
//            let json = try? JSON(data: data)  //пока убрал так как решил что свифти не оч подходит тут
            do {
                let parcing = try JSONDecoder().decode(MainParsing.self, from: data)
                DispatchQueue.main.async {
                    complition(parcing)
                }
            } catch {
                
            }
        }
    }
    
    func sendRequestWithCoordinates(requestType: RequestType, endpoints: EndPoints, key: String, complition: @escaping (Data?) -> Void) {
        guard let dataCoordinates = locationManager.currentLocation else {return}
        coordinates = Coordinates(lat: dataCoordinates.latitude, lon: dataCoordinates.longitude)
        guard let URL = URL(string: "\(siteURL)\(endpoints.rawValue)\(coordinatesURL)\(key)") else {return complition (nil)}
        print (URL)
        var request = URLRequest(url: URL)
        request.httpMethod = requestType.rawValue
        
        URLSession.shared.dataTask(with: request) { data, error, response in
            guard error == error else {return
                complition (nil)
            }
            complition(data)
        } .resume()
    }
    
//    func coordinatesAdd(complition: @escaping (CLLocationCoordinate2D?) -> Void) {
//        locationManager.start()
//        
//        guard let coordinatesCurrent = locationManager.currentLocation else {return}
//        complition(coordinatesCurrent)
//        coordinates = Coordinates(lat: coordinatesCurrent.latitude, lon: coordinatesCurrent.longitude)
//        print(coordinates)
//    }
}
