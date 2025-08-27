//
//  TodoListApp.swift
//  TodoList
//
//  Created by Sandesh on 24/08/25.
//

import SwiftUI
import FirebaseCore

@main
struct TodoListApp: App {
    
    init () {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
