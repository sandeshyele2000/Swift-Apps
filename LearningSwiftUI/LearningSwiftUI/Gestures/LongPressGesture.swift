//
//  LongPressGesture.swift
//  LearningSwiftUI
//
//  Created by Sandesh on 04/09/25.
//

import SwiftUI

struct LongPressGesture: View {
    
    @State private var isComplete: Bool = false
    @State private var isSuccess: Bool = false
    @State private var isAnimating = false
    var progress: Double

    var body: some View {
        VStack {
            Text("onLongPressGesture").font(.title)
            circle
            rectangle
            controls
        }
    }
    
    var circle: some View {
        ZStack {
            Circle()
                .stroke(Color.red, lineWidth: 50)
            
            Circle()
                .trim(from: 0, to: isComplete ? 1 : 0)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [isSuccess ? Color.green : Color.yellow]),
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 50, dash: [10, 2])
                )
                .rotationEffect(.degrees(180))
                .animation(.easeOut(duration: 1), value: progress)
                        
        }
        .frame(width: 200, height: 200)
        .padding(30)
    }
    
    var rectangle: some View {
        Rectangle()
            .fill(isSuccess ? Color.green : Color.yellow)
            .frame(maxWidth: isComplete ? .infinity: 0)
            .frame(height: 50)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.red)
    }
    
    var controls: some View {
        HStack {
            Text("Long Press")
                .padding()
                .background(Color.mint)
                .cornerRadius(10)
                .onLongPressGesture(minimumDuration: 2.0) {
                    // action to be performed just at minimumDuration
                    withAnimation(.easeInOut(duration: 1.0)) {
                        isSuccess = true
                    }
                    
                } onPressingChanged: { (isPressing) in
                    // action to be performed on change of pressing action
                    if isPressing {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            isComplete = true
                        }
                    } else {
                        
                        // to perform action at later point on the main thread
                        // removing or adding this did not matter here.
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            if !isSuccess {
                                withAnimation(.easeInOut(duration: 1.0)) {
                                    isComplete = false
                                }
                            }
                            
                        }
                        
                    }
                }

                
            Text("Reset")
                .padding()
                .background(Color.mint)
                .cornerRadius(10)
                .onTapGesture {
                    withAnimation(.snappy(duration: 1.0)) {
                        isComplete = false
                        isSuccess = false
                    }
                    
                }
        }.padding()
    }
    
    var basicUsage : some View {
        Text(isComplete ? "pressed": "not pressed")
            .padding()
            .background(isComplete ? Color.blue : Color.green)
            .cornerRadius(10)
            .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 150) {
                isComplete.toggle()
            }
    }
}

#Preview {
    LongPressGesture(progress: 1)
}
