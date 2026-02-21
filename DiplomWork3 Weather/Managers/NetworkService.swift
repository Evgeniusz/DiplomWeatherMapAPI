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
    func currentCityRequest(complition: @escaping (MainParsing) -> Void)
    func coordinatesCityRequest(coordinates: Coordinates, complition: @escaping (MainParsing) -> Void)
    func cityRequest(text: String, complition: @escaping ([CityNames]) -> Void)
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
    let apiKey: String = "&appid=713aa71dc84d2ca8a2ef48566162ba05"
    let units: String = "metric"
    var lanuage: Languages = .Belarus
    
    
    //MARK: Request to API - current location by LocationManager
    func currentCityRequest(complition: @escaping (MainParsing) -> Void){
        sendRequestWithCurrentCoordinates(requestType: .GET, endpoints: .baseURLCoordinates , key: apiKey) { data in
            guard let data else {return}
            do {
                let parcing = try JSONDecoder().decode(MainParsing.self, from: data)
                DispatchQueue.main.async {
                    complition(parcing)
                }
            } catch {
                
            }
        }
    }
    
    func sendRequestWithCurrentCoordinates(requestType: RequestType, endpoints: EndPoints, key: String, complition: @escaping (Data?) -> Void) { //here two
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
    
    //MARK: Request to API - search by name
    func sendRequestWithCityNameByUser(requestType: RequestType, endpoints: EndPoints, city: String, key: String, complition: @escaping (Data?) -> Void){
        guard let URL = URL(string:"\(siteURL)\(endpoints.rawValue)\(city)&limit=5\(key)") else {return complition (nil)}
        print(URL)
        var request = URLRequest(url: URL)
        request.httpMethod = requestType.rawValue
        
        URLSession.shared.dataTask(with: request) {data, error, response in
            guard error == error else {
                return complition (nil)
            }
            complition(data)
        } .resume()
    }
    
//    func cityRequest(text: String, complition: @escaping ([CityNames]) -> Void){
//        sendRequestWithCityNameByUser(requestType: .GET, endpoints: .baseURlCity, city: text, key: apiKey) { data in
//            guard let data,
//                  let json = try? JSON(data: data),
//                  let array = json.array else {return}
//            
//            var cityArrayResponse = [CityNames]()
//            array.forEach {
//                if let name = $0["name"].string,
//                   let lat = $0["lat"].double,
//                   let lon = $0["lon"].double,
//                   let country = $0["country"].string
//                {
//                    let city = CityNames(name: name, lat: lat, lon: lon, country: country)
//                    cityArrayResponse.append(city)
//                }
//                   
//            }
//            complition (cityArrayResponse)
//        }
//    }
    
    //MARK: Test block of code 2
    
    func cityRequest(text: String, complition: @escaping ([CityNames]) -> Void){
        sendRequestWithCityNameByUser(requestType: .GET, endpoints: .baseURlCity, city: text, key: apiKey) { data in
            guard let data,
                  let json = try? JSON(data: data),
                  let array = json.array else {return}
            
            var cityArrayResponse = [CityNames]()
            array.forEach {
                guard let curentLanguage = Locale.current.language.languageCode?.identifier else {return}
                if let name = $0["name"].string,
                   let lat = $0["lat"].double,
                   let lon = $0["lon"].double,
                   let country = $0["country"].string,
                   let localName = $0["local_names"].dictionaryValue[curentLanguage]?.string
                {
                    let city = CityNames(name: name, lat: lat, lon: lon, country: country, localNames: localName)
                    cityArrayResponse.append(city)
                }
                   
            }
            complition (cityArrayResponse)
        }
    }
    
    //MARK: Request to API - search by coordinates - response by city Name
    func coordinatesRequest(requestType: RequestType, endpoints: EndPoints, key: String, coordinatesFrom: Coordinates, complition: @escaping (Data?) -> Void) {
        coordinates = Coordinates(lat: coordinatesFrom.lat, lon: coordinatesFrom.lon)
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
    
    func coordinatesCityRequest(coordinates: Coordinates, complition: @escaping (MainParsing) -> Void){
        coordinatesRequest(requestType: .GET, endpoints: .baseURLCoordinates , key: apiKey, coordinatesFrom: coordinates) { data in
            guard let data else {return}
            do {
                let parcing = try JSONDecoder().decode(MainParsing.self, from: data)
                DispatchQueue.main.async {
                    complition(parcing)
                }
            } catch {
                
            }
        }
    }
}
