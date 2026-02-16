//
//  extensions+UserDefaults.swift
//  DiplomWork3 Weather
//
//  Created by Apple on 16.02.26.
//
import UIKit

extension UserDefaults {
    func set<T: Encodable> (encodable: T?, for key: String){
        if let data = try? JSONEncoder().encode(encodable){
            set(data, forKey: key)
        }
    }
    
    func get<T: Decodable>(decodable: T.Type, for key: String) -> T?{
        guard let data = data(forKey: key) else {return nil}
        return try? JSONDecoder().decode(decodable, from: data)
    }
}
