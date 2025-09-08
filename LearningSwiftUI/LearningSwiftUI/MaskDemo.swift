//
//  MaskDemo.swift
//  LearningSwiftUI
//
//  Created by Sandesh on 07/09/25.
//

import SwiftUI

struct MaskDemo: View {
    
    @State var rating: Int = 0
    
    private let size: CGFloat = 70
    
    var StarView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: size, height: size)
                    .foregroundStyle(Color.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index
                        }
                    }
                    
            }
        }
    }
    
    var OverlayView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.yellow)
                    .frame(
                        width: CGFloat(rating) / 5 * geometry.size.width,
                        height: size
                    )
                
            }
        }.allowsHitTesting(false) // to allow clicking through this overlay
    }
    
    var body: some View {
        Text("Mask").font(.title)
        
        StarView
            .overlay {
                OverlayView
                    .mask(StarView)
            }
        
        
        
        
    }
}

#Preview {
    MaskDemo()
}
