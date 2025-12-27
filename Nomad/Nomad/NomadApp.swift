//
//  NomadApp.swift
//  Nomad
//
//  Created by Sandesh on 23/12/25.
//

import SwiftUI

@main
struct NomadApp: App {

    @StateObject private var locationManager = LocationManager()
    @StateObject private var photoService = PhotoService()
    @StateObject private var routeService = RouteService()
    @StateObject private var authService = AuthService()

    var body: some Scene {
        WindowGroup {
            if authService.isLoggedIn {
                RootTabView()
                    .environmentObject(locationManager)
                    .environmentObject(photoService)
                    .environmentObject(routeService)
                    .environmentObject(authService)
            } else {
                LoginView()
                    .environmentObject(authService)
            }
        }
    }
}
