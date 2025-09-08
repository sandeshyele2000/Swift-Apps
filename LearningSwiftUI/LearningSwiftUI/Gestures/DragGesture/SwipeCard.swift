//
//  DragGesture.swift
//  LearningSwiftUI
//
//  Created by Sandesh on 06/09/25.
//

import SwiftUI

struct SwipeCard: View {
    
    @State private var translation: CGSize = .zero
       
       var body: some View {
           Text("DragGesture").font(.title)
           Text("\(translation.width)")
           RoundedRectangle(cornerRadius: 20)
               .frame(width: 300, height: 500)
               .offset(translation)
               .rotationEffect(getRotationAmount(translation))
               .scaleEffect(getScaleAmount(translation))
               .gesture(
                   DragGesture()
                       .onChanged { value in
                           withAnimation (.spring) {
                               translation = value.translation
                           }
                       }
                        .onEnded { value in
                            withAnimation (.spring) {
                                translation = .zero
                            }
                        }
               )
       }
    
    func getRotationAmount (_ translation: CGSize) -> Angle {
        let maxWidth = UIScreen.main.bounds.width / 2
        let currentAmount = translation.width
        let percentageDrag = currentAmount / maxWidth
        let angleToBeRotated: CGFloat = 10
        return Angle(degrees: Double(angleToBeRotated * percentageDrag))
    }
    
    func getScaleAmount (_ translation: CGSize) -> Double {
        let maxWidth = UIScreen.main.bounds.width / 2
        let currentAmount = abs(translation.width)
        let percentageDrag = currentAmount / maxWidth
        return 1.0 - min(percentageDrag, 0.5) * 0.5
    }
}

#Preview {
    SwipeCard()
}
