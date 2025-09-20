//
//  GeometryReaderDemo.swift
//  LearningSwiftUI
//
//  Created by Sandesh on 06/09/25.
//
import SwiftUI

// MARK: - (type erasure wrapper)
struct AnyShape: Shape {
    
    private let _path: @Sendable (CGRect) -> Path
    
    init<S: Shape>(_ shape: S) {
        _path = { rect in
            shape.path(in: rect)
        }
    }
    
    // implemented the Shape protocol or interface's path function
    func path(in rect: CGRect) -> Path {
        _path(rect) // SwiftUI is the one supplying rect, while drawing a shape
        // here we forwarded the function call to call the actual shape's path
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}


struct GeometryReaderDemo: View {
    
    let shapes: [Int: AnyShape] = [
        0: AnyShape(Circle()),
        1: AnyShape(RoundedRectangle(cornerRadius: 30)),
        2: AnyShape(Triangle())
    ]
    
    let colors: [Color] = [.indigo, .blue, .green, .yellow, .orange, .red]

    func getRateOfChange(_ geo: GeometryProxy) -> Double {
        let maxHeight = UIScreen.main.bounds.height / 2
        let currentPosition = geo.frame(in: .global).midY
        return Double(1 - (currentPosition / maxHeight))
    }
    
    func getShape(index: Int) -> AnyShape {
        shapes[index % shapes.count]!
    }
    
    // MARK: - main view
    
    var body: some View {
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(1..<100) { index in
                        GeometryReader { geometry in
                            getShape(index: 1)
                                .fill(colors[index%colors.count])
                                .rotation3DEffect(
                                    Angle(degrees: getRateOfChange(geometry) * 180),
                                    axis: (x: -1, y: 1, z: 0)
                                )
                        }
                        .frame(width: 300, height: 40)
                    }
                }.padding(100)
            }
            .overlay(
                Text("Geometry Reader")
                    .offset(y: -20)
                    .bold()
                    .foregroundStyle(Color.white)
            )
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .ignoresSafeArea()
            
            
        
    }
    
}

#Preview {
    GeometryReaderDemo()
}
