//
//  PhotoAnnotation.swift
//  Nomad
//
//  Created by Sandesh on 24/12/25.
//

import MapKit

class PointAnnotation: MKPointAnnotation, Identifiable {

    let logs: [TravelLog]
    let id: String
    
    init(logs: [TravelLog]) {
        precondition(!logs.isEmpty, "PointAnnotation requires at least one TravelLog")
        self.logs = logs
        let first = logs[0]
        self.id = "\(first.latitude.rounded())_\(first.longitude.rounded())"
        super.init()
        self.coordinate = first.coordinate
    }

}
