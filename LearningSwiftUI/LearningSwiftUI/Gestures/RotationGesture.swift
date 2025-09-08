//
//  RotationGesture.swift
//  LearningSwiftUI
//
//  Created by Sandesh on 06/09/25.
//

import SwiftUI

struct RotationGesture: View {
    
    @State var rotation: Angle = .zero
    
    
    var body: some View {
        Text("Rotate Gesture")
            .font(.title)
            .padding(40)
            .background(Color.blue)
            .rotationEffect(rotation)
            .gesture(
                RotateGesture()
                    .onChanged { value in
                        rotation = value.rotation
                    }
                    .onEnded{ value in
                        print("on Ended called")
                        withAnimation(.spring(duration: 1.0)) {
                            rotation = .zero
                        }
                        
                    }
            )

    }
}

#Preview {
    RotationGesture()
}
