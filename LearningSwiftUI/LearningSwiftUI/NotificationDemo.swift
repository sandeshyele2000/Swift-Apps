//
//  NotificationDemo.swift
//  LearningSwiftUI
//
//  Created by Sandesh on 20/09/25.
//

import SwiftUI


class NotificationManager {
    
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Authorization granted")
            }
        }
    }
    
    func scheduleNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
    }
    
    
}



struct NotificationDemo: View {
    var body: some View {
        Button("Request Authorization") {
            NotificationManager.instance.requestAuthorization()
        }
    }
}

#Preview {
    NotificationDemo()
}
