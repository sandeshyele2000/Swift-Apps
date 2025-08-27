//
//  TLButton.swift
//  TodoList
//
//  Created by Sandesh on 24/08/25.
//

import SwiftUI

struct TLButton: View {
    let title: String
    let backgroundColor: Color
    let foregroundColor: Color
    let action: () -> Void   // allow action

    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(backgroundColor)
                    .frame(height: 40)
                
                Text(title)
                    .foregroundColor(foregroundColor)
                    .bold()
            }.background()
        }.buttonStyle(BorderlessButtonStyle())
    }
}


