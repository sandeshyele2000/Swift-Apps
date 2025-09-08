//
//  MultipleSheets.swift
//  LearningSwiftUI
//
//  Created by Sandesh on 07/09/25.
//

import SwiftUI


// NOTE:
// Identifiable is like providing a key for Swift
// to compute diff and render
// otherwise it would inefficiently paint entire layout

struct RandomModelForContent: Identifiable {
    let id: String = UUID().uuidString
    let name: String
}


struct NextScreen: View {
    
    @Binding var model: RandomModelForContent?
    var body: some View {
        VStack {
            Color.green.ignoresSafeArea()
        }.overlay {
            VStack {
                Text(model?.name ?? "No name")
                Text(model?.id ?? "No id")
            }
        }
    }
}

struct NextScreen2: View {
    
    let model: RandomModelForContent?
    var body: some View {
        VStack {
            Color.blue.ignoresSafeArea()
        }.overlay {
            VStack {
                Text(model?.name ?? "No name")
                Text(model?.id ?? "No id")
            }
        }
    }
}


struct MultipleSheets: View {
    
    @State var selectedModel: RandomModelForContent? = nil
    @State var showSheet: Bool = false
    
    @State var selectedModel2: RandomModelForContent? = nil
    @State var showSheet2: Bool = false
    
    var body: some View {
        Text("Multiple Sheets").font(.title)
        
// MARK: - 1. Using Binding Method
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(0..<15) { index in
                    Button("\(index)") {
                        selectedModel = RandomModelForContent(name: "Button \(index)")
                        showSheet.toggle()
                    }
                    .padding(30)
                    .background(Color.green)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
                }
            }

            .sheet(isPresented: $showSheet) {
                NextScreen(model: $selectedModel)
            }
        }.padding()
        
// MARK: - 2. Passing the model as an item to the sheet
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(0..<15) { index in
                    Button("\(index)") {
                        selectedModel2 = RandomModelForContent(name: "Button \(index)")
                        showSheet2.toggle()
                    }
                    .padding(30)
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
                }
            }

            .sheet(item: $selectedModel2) { model in
                NextScreen2(model: model)
            }
        }.padding()
       
    }
}



#Preview {
    MultipleSheets(selectedModel: .init(name: ""))
}
