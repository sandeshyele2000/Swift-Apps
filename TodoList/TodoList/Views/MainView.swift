//
//  ContentView.swift
//  TodoList
//
//  Created by Sandesh on 24/08/25.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var mainViewModel = MainViewViewModel()
    var body: some View {
        if(mainViewModel.isSignedIn && !mainViewModel.currentUserId.isEmpty){
            accountView
        } else {
            LoginView()
        }
    }
    
    // View builder annotation is not needed in this case
    // as it is part of already wrapped body
    @ViewBuilder
    var accountView: some View {
        TabView {
            TodoListView(userId: mainViewModel.currentUserId).tabItem {
                Label("Home", systemImage: "house")
            }
            
            ProfileView().tabItem {
                Label("Profile", systemImage: "person.circle")
            }
                
        }
    }
}

#Preview {
    MainView()
}
