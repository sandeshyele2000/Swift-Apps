//
//  ExploreVIew.swift
//  Nomad
//
//  Created by Sandesh on 25/12/25.
//

import SwiftUI
import MapKit
import PhotosUI

struct ExploreView: View {
    @EnvironmentObject private var locationManager: LocationManager
    @EnvironmentObject private var photoService: PhotoService
    @StateObject private var routeService = RouteService()
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
                    latitude: 37.334722,
                    longitude: -122.008889),
        span: MKCoordinateSpan(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01
        )
    )
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var showCamera: Bool = false
    
    
    @State private var selectedPointAnnotation: PointAnnotation?
    
    @State private var recenterTriggered: Bool = false
    
    @State private var isExpanded = false



    var body: some View {
        ZStack{
            MapView
            ActionsView
            FloatingActionButton
        }
        .sheet(isPresented: $showCamera) {
            CameraView { image in
                handleImage(image: image)
            }
        }
        
    }
    
    private func handleImage(image: UIImage) {
        if let location = locationManager.currentLocation {
            photoService.addPhoto(image: image, location: location)
        }
    }
}


extension ExploreView {
    
    var MapView: some View {
        RouteMapView(
            region: region,
            coordinates: routeService.coordinates,
            polylineColor: UIColor.blue,
            polylinewidth: 4,
            groupedLogsByLocation: photoService.logsGroupedByLocation,
            selectedPointAnnotation: $selectedPointAnnotation,
            recenterTriggered: recenterTriggered
        )
        .onReceive(locationManager.$currentLocation) { location in
            guard let location else { return }
            routeService.append(location)
            region = MKCoordinateRegion(
                    center: location.coordinate,
                    span: region.span
                )
        }
        .sheet(item: $selectedPointAnnotation) { annotation in
            CarouselPreview(logs: annotation.logs)
        }
    
    }
    
    
    
    var ActionsView: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    if let location = locationManager.currentLocation {
                        region = MKCoordinateRegion(
                            center: location.coordinate,
                            span: region.span
                        )
                        recenterTriggered.toggle()
                    }
                }) {
                    Image(systemName: "scope")
                        .font(.title2)
                        .frame(width: 45, height: 45)
                        .foregroundStyle(Color.white)
                        
                }.background {
                    Circle()
                        .fill(Color.blue)
                        .shadow(radius: 1)
                }
            }.padding(.trailing, 24)
            Spacer()
        }.padding(.top, 25)
    }
    
    var FloatingActionButton: some View {
        FABView(
            isExpanded: $isExpanded,
            menuItems: [
                FABMenuItem(view: AnyView(
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        Image(systemName: "photo")
                            .foregroundStyle(Color.white)
                            
                    }
                        
                )),
                FABMenuItem(view: AnyView(
                    Image(systemName: "camera")
                        .foregroundStyle(Color.white)
                        .onTapGesture {
                            showCamera.toggle()
                            toggleExpanded()
                        }
                )),
            ]
        )
        .onChange(of: selectedItem) { _, newItem in
            toggleExpanded()
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let image = UIImage(data: data),
                   let location = locationManager.currentLocation {
                    photoService.addPhoto(image: image, location: location)
                  
                }
               
            }
        }
    }
    
    func toggleExpanded() {
        withAnimation(.spring) {
            isExpanded.toggle()
        }
    }
}


#Preview {
    ExploreView()
        .environmentObject(LocationManager())
        .environmentObject(PhotoService())
}
