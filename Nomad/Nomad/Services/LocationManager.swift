//
//  LocationManager.swift
//  Nomad
//
//  Created by Sandesh on 23/12/25.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {
    
    private let manager = CLLocationManager()
    
    @Published var currentLocation: CLLocation?
    
    @Published var authorizationStatus: CLAuthorizationStatus
    
    override init() {
        self.authorizationStatus = manager.authorizationStatus
        super.init()
        manager.delegate = self // making current class as delegate of cllocationmanger by this we can get info
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
}


extension LocationManager: CLLocationManagerDelegate {
    
    // Called whenever location changes
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // setting the current location
        currentLocation = locations.last
    }
    
    // Called when authorization status changes
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        
        if authorizationStatus == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        } else {
            manager.stopUpdatingLocation()
        }
        
    }
    
    // handle errors
    func locationManager(
      _ manager: CLLocationManager,
      didFailWithError error: Error
    ) {
      print("LocationManager error: \(error.localizedDescription)")
    }
    
}
