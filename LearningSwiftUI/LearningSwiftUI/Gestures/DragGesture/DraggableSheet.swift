//
//  DraggableSheet.swift
//  LearningSwiftUI
//
//  Created by Sandesh on 06/09/25.
//

import SwiftUI

struct DraggableSheet: View {
    @State private var startingOffset: CGFloat = UIScreen.main.bounds.height * 0.80
    @State private var currentOffset: CGFloat = 0
    @State private var endOffset: CGFloat = 0
    
    var totalOffset: CGFloat {
        startingOffset + currentOffset + endOffset
    }
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            Text("DragGesture").font(.title)

            Sheet()
                .offset(y: totalOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let dragAmount = value.translation.height
                            
                            if endOffset == -startingOffset && dragAmount < 0 {
                                currentOffset = 0
                                return
                            }
                            
                            if endOffset == 0 && dragAmount > 0 {
                                currentOffset = 0
                                return
                            }
                            
                            currentOffset = dragAmount
                        }
                        .onEnded { _ in
                            withAnimation(.spring()) {
                                if currentOffset < -150 {
                                    endOffset = -startingOffset // expand
                                } else if currentOffset > 150 {
                                    endOffset = 0 // collapse
                                }
                                currentOffset = 0
                            }
                        }
                )
        }
    }
}

struct Sheet: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "chevron.up")
                .padding()
            
            Text("Sign up")
                .font(.system(size: 30, weight: .bold))
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("This is a description This is a description This is a description This is a description")
                .padding()
                .multilineTextAlignment(.center)
            
            Button {
                // action
            } label: {
                Text("CREATE AN ACCOUNT")
                    .font(.headline)
                    .padding()
                    .background(Color.green.cornerRadius(10))
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    DraggableSheet()
}
