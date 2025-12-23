//
//  SearchBarView.swift
//  Crypto
//
//  Created by Sandesh on 12/10/25.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    !searchText.isEmpty ? Color.theme.accent : Color.theme.secondaryTextColor
                )
            TextField("Search by name or symbol...", text: $searchText)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color.theme.accent)
                        .padding()
                        .offset(x: 10)
                        .opacity( searchText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            searchText = ""
                            UIApplication.shared.endEditing()
                        }
                    ,
                    alignment: .trailing
                )
        }
        .font(.headline)
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.15),
                    radius: 10,
                    x:0,
                    y:0
                )
        )
        .padding()
        
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
