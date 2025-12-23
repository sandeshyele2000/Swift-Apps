//
//  ContentView.swift
//  Crypto
//
//  Created by Sandesh on 20/09/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       
        ZStack {
            Color.theme.background.ignoresSafeArea()
            VStack {
                Text("Crypto")
                    .foregroundStyle(Color.theme.accent)
                Text("Crypto")
                    .foregroundStyle(Color.theme.green)
                Text("Crypto")
                    .foregroundStyle(Color.theme.red)
                Text("Crypto")
                    .foregroundStyle(Color.theme.secondaryTextColor)
            }
        }
    }
}

#Preview {
    ContentView()
}
