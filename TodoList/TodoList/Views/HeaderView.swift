//
//  HeaderView.swift
//  TodoList
//
//  Created by Sandesh on 24/08/25.
//

import SwiftUI

struct HeaderView: View {
    
    let title: String
    let subtitle: String
    let backgroundColor: Color
    let angle: Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundStyle(backgroundColor)
                .rotationEffect(Angle(degrees: angle))
            
            VStack {
                Text(title)
                    .font(.system(size: 40))
                    .bold()
                    .foregroundStyle(Color.white)
                
                Text(subtitle)
                    .font(.system(size: 20))
                    .foregroundStyle(Color.white)
                
            }.padding(.top, 80)
            
        }.frame(width: UIScreen.main.bounds.width*3, height: 300)
        .offset(y: -140)
    }
}

struct HeaderViewPrefix_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Title", subtitle: "Subtitle", backgroundColor: Color.blue, angle: 15)
    }
}
