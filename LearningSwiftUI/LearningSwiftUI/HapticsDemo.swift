//
//  HapticsDemo.swift
//  LearningSwiftUI
//
//  Created by Sandesh on 18/09/25.
//

import SwiftUI


class HapticManager {
    
    static let instance = HapticManager()
    
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct HapticsDemo: View {
    var body: some View {
        
        let hp = HapticManager.instance
        
        Text("Hello, World!")
            .onTapGesture {
                hp.notification(type: .success)
            }
    }
}

#Preview {
    HapticsDemo()
}
