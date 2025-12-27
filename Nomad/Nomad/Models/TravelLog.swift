//
//  TravelLog.swift
//  Nomad
//
//  Created by Sandesh on 24/12/25.
//

import CoreLocation

struct TravelLog: Identifiable, Codable {
    let id: UUID
    let latitude: Double
    let longitude: Double
    let date: Date
    let photoData: Data
}


extension TravelLog {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude,
                               longitude: longitude)
    }
    
    var locationKey: LocationKey {
        LocationKey(coordinate: coordinate)
    }
}


struct LocationKey: Hashable {
    let lat: Int
    let lon: Int

    init(coordinate: CLLocationCoordinate2D, precision: Double = 0.0001) {
        self.lat = Int(coordinate.latitude / precision)
        self.lon = Int(coordinate.longitude / precision)
    }
}
