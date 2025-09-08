//
//  MagnificationGesture.swift
//  LearningSwiftUI
//
//  Created by Sandesh on 06/09/25.
//

import SwiftUI

struct MagnificationGesture: View {
    
    @State var currentAmount: CGFloat = 0
    @State var prevAmount: CGFloat = 0
    
    var body: some View {
        Text("MagnifyGesture!")
            .font(.title)
            .foregroundStyle(.white)
            .padding(40)
            .background(Color.red)
            .scaleEffect(1 + currentAmount + prevAmount)
            .gesture(
                MagnifyGesture()
                    .onChanged {  value in
                        currentAmount = value.magnification - 1
                    }
                    .onEnded { value in
                        prevAmount += currentAmount
                        currentAmount = 0
                    }
            )
        
    }
}

#Preview {
    MagnificationGesture()
}
