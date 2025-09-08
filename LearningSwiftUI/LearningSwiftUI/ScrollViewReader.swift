//
//  ScrollViewReaderDemo.swift
//  LearningSwiftUI
//
//  Created by Sandesh on 06/09/25.
//

import SwiftUI

struct ScrollViewReaderDemo: View {
    
    @State private var scrollToIndex: String = ""
    
    let colors: [Color] = [.indigo, .blue, .green, .yellow, .orange, .red]
    
    var body: some View {
        
        VStack {
            Text("ScrollView Reader").font(.title)
            inputField
            
            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(1..<101, id: \.self) { index in
                        ItemRow(index: index, color: colors[index % colors.count])
                    }
                    .onChange(of: scrollToIndex) { _, newValue in
                        scrollTo(proxy: proxy, newValue: newValue)
                    }
                }
            }
        }
    }
    
    // MARK: - UI Parts
    
    private var inputField: some View {
        TextField("Enter index (1–100)", text: $scrollToIndex)
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            .keyboardType(.numberPad)
            .padding()
    }
    
    
    // MARK: - Logic
    
    private func scrollTo(proxy: ScrollViewProxy, newValue: String) {
        if let intVal = Int(newValue), (10..<110).contains(intVal) {
            withAnimation {
                proxy.scrollTo(intVal, anchor: .center)
            }
        }
    }
}

struct ItemRow: View {
    let index: Int
    let color: Color
    
    var body: some View {
        Text("Item \(index)")
            .foregroundStyle(.white)
            .padding()
            .font(.system(size: 20, weight: .bold))
            .frame(maxWidth: .infinity)
            .frame(height: 150)
            .background(color)
            .cornerRadius(20)
            .id(index) // important for scrollTo
    }
}

#Preview {
    ScrollViewReaderDemo()
}
