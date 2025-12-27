//
//  PhotoService.swift
//  Nomad
//
//  Created by Sandesh on 24/12/25.
//

import Foundation
import SwiftUI
import CoreLocation

class PhotoService: ObservableObject {
    
    // TODO: will be picked from DB
    @Published var travelLogs: [TravelLog] = []
    
    var logsGroupedByLocation: [LocationKey: [TravelLog]] {
        Dictionary(grouping: travelLogs) { $0.locationKey }
    }

    // TODO: will be doing DB operation here
    func addPhoto(image: UIImage, location: CLLocation) {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
    
        let log = TravelLog(
            id: UUID(),
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude,
            date: Date(),
            photoData: data
        )
        
        travelLogs.append(log)
    }
}


