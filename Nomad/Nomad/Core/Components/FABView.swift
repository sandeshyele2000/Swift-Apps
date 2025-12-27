//
//  FABView.swift
//  Nomad
//
//  Created by Sandesh on 26/12/25.
//

import SwiftUI


struct FABMenuItem: Identifiable {
    let id = UUID()
    let view: AnyView
}

struct FABView: View {
    @Binding var isExpanded: Bool
    var menuItems: [FABMenuItem]
    var fabSize: CGFloat = 56

    var body: some View {
        ZStack {
            if isExpanded {
                overlay
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    FAB
                }
            }
        }
    }
    
    func toggleExpanded() {
        withAnimation(.spring()) {
            isExpanded.toggle()
        }
    }
}

extension FABView {
    var overlay: some View {
        Color.black
            .opacity(0.3)
            .ignoresSafeArea()
            .onTapGesture {
                toggleExpanded()
            }
    }
    
    var itemView: some View {
        ForEach(menuItems.reversed()) { item in
            Circle()
                .fill(Color.blue)
                .frame(width: 45, height: 45)
                .overlay(content: {item.view})
                .opacity(isExpanded ? 1 : 0)
                .offset(y: isExpanded ? 0 : 40)
                .animation(.spring(), value: isExpanded)
                .padding(.trailing, 6)
        }
    }
    
    var FAB: some View {
        VStack(alignment: .trailing, spacing: 16) {
            itemView

            Button {
                toggleExpanded()
            } label: {
                Circle()
                    .frame(width: fabSize, height: fabSize)
                    .overlay(
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.white)
                            .rotationEffect(.degrees(isExpanded ? 45 : 0))
                    )
                    .shadow(radius: 6)
            }
            .padding(.bottom, 25)
        }
        .padding(.trailing, 24)
    }
}

struct ContentViewFAB: View {
    @State private var showCamera = false
    @State private var isExpanded = false

    var body: some View {
        ZStack {
            Text("Hello world")

            FABView(
                isExpanded: $isExpanded,
                menuItems: [
                FABMenuItem(view: AnyView(
                    Image(systemName: "photo")
                        .onTapGesture {
                            isExpanded.toggle()
                        }
                )),
                FABMenuItem(view: AnyView(
                    Image(systemName: "camera")
                        .onTapGesture {
                            isExpanded.toggle()
                        }
                )),
            ])
        }
        .sheet(isPresented: $showCamera) {
            Text("Camera View Placeholder")
        }
    }
}


#Preview {
    ContentViewFAB()
}
