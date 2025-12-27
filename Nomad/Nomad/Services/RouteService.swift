//
//  RouteStore.swift
//  Nomad
//
//  Created by Sandesh on 24/12/25.
//

import Foundation
import CoreLocation

class RouteService: ObservableObject {
    
    @Published var coordinates: [CLLocationCoordinate2D] = []
    
    func append(_ location: CLLocation) {
        guard let last = coordinates.last else {
            coordinates.append(location.coordinate)
            return
        }

        let lastLocation = CLLocation(latitude: last.latitude,
                                      longitude: last.longitude)

        if location.distance(from: lastLocation) > 5 {
            coordinates.append(location.coordinate)
        }
    }
    
    func reset() {
        coordinates.removeAll()
    }
    
}
