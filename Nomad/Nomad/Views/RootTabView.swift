//
//  RootTabView.swift
//  Nomad
//
//  Created by Sandesh on 25/12/25.
//

import SwiftUI

struct RootTabView: View {

    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var photoService: PhotoService
    @EnvironmentObject var routeService: RouteService
    @EnvironmentObject var authService: AuthService


    var body: some View {
        ZStack {
            TabView {
                ExploreView()
                    .tabItem {
                        Label("Explore", systemImage: "map")
                    }
                MemoriesView()
                    .tabItem {
                        Label("Memories", systemImage: "photo.on.rectangle")
                    }
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
            }

        }
        
    }

}

#Preview {
    RootTabView()
        .environmentObject(LocationManager())
        .environmentObject(PhotoService())
}
