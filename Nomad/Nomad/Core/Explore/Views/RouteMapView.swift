//
//  RouteMapView.swift
//  Nomad
//
//  Created by Sandesh on 24/12/25.
//

import MapKit
import SwiftUI

// Custom Route Map

struct RouteMapView: UIViewRepresentable {
    
    var region: MKCoordinateRegion
    var coordinates: [CLLocationCoordinate2D]
    var polylineColor: UIColor = UIColor.blue
    var polylinewidth: CGFloat = 4
    var groupedLogsByLocation: [LocationKey: [TravelLog]]
    @Binding var selectedPointAnnotation: PointAnnotation?
    var recenterTriggered: Bool = false

    
    // overriding makeUIView
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        
        mapView.layoutMargins = UIEdgeInsets(
            top: 75,
            left: 16,
            bottom: 16,
            right: 16
        )
        mapView.setRegion(region, animated: false)
        return mapView
    }
    
    // overriding updateUIView
    func updateUIView(_ mapView: MKMapView, context: Context) {
       manageOverlays(mapView)
       manageAnnotations(mapView)
        // Force recenter if triggered
        if context.coordinator.lastRecenterTriggered != recenterTriggered {
            context.coordinator.lastRecenterTriggered = recenterTriggered
            mapView.setRegion(region, animated: true)
        } else if abs(mapView.region.center.latitude - region.center.latitude) > 0.00001 ||
                  abs(mapView.region.center.longitude - region.center.longitude) > 0.00001 {
            mapView.setRegion(region, animated: true)
        }
    }
    
    // overriding makeCoordinator
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    // helper functions
    func manageOverlays(_ mapView: MKMapView) {
        mapView.removeOverlays(mapView.overlays)
        let polyline = MKPolyline(
                         coordinates: coordinates,
                         count: coordinates.count
                       )
        mapView.addOverlay(polyline)
    }
    
    func manageAnnotations(_ mapView: MKMapView) {
        // Remove old photo pins
        mapView.removeAnnotations(mapView.annotations.filter { $0 is PointAnnotation })
        // Add photo pins/annotations list according to location
        let annotations = groupedLogsByLocation.map { (_, logs) in PointAnnotation(logs: logs)}
        mapView.addAnnotations(annotations)
    }
    
    
    final class Coordinator: NSObject, MKMapViewDelegate {
        let parent: RouteMapView
        var lastRecenterTriggered: Bool = false
        
        init(parent: RouteMapView) {
            self.parent = parent
        }
        
        
        // overriding methods of Map Kit
        func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = parent.polylineColor
            renderer.lineWidth = parent.polylinewidth
            return renderer
        }
        
        
        func mapView(_ mapView: MKMapView,
                         viewFor annotation: MKAnnotation) -> MKAnnotationView? {

            guard annotation is PointAnnotation else { return nil }

            let identifier = "PhotoPin"
            let view = mapView.dequeueReusableAnnotationView(
                withIdentifier: identifier
            ) ?? MKMarkerAnnotationView(annotation: annotation,
                                        reuseIdentifier: identifier)

            view.canShowCallout = true
            view.image = UIImage(systemName: "camera.fill")
            return view
        }

        func mapView(_ mapView: MKMapView,
                     didSelect view: MKAnnotationView) {

            guard let annotation = view.annotation as? PointAnnotation else { return }
            parent.selectedPointAnnotation = annotation
        }
    }
    
    
}
