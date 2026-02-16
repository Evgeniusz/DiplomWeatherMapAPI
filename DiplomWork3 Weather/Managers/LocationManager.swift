//
//  LocationManager.swift
//  DiplomWork3 Weather
//
//  Created by Apple on 30.01.26.
//

import UIKit
import CoreLocation


final class LocationManager: NSObject {
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let locationUpdateNow = locationManager.location?.coordinate else {return}
        currentLocation = locationUpdateNow
    }
}
