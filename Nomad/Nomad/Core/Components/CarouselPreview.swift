//
//  CarouselPreview.swift
//  Nomad
//
//  Created by Sandesh on 28/12/25.
//

import SwiftUI

struct CarouselPreview: View {
    
    let logs: [TravelLog]
    
    @State private var selectedIndex: Int = 0

        var body: some View {
            VStack(spacing: 12) {

                // Paging carousel
                TabView(selection: $selectedIndex) {
                    ForEach(Array(logs.enumerated()), id: \.element.id) { index, log in
                        Image(uiImage: UIImage(data: log.photoData)!)
                            .resizable()
                            .scaledToFit()
                            .tag(index)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.horizontal)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .automatic))

                // Metadata
                VStack(spacing: 4) {
                    Text(logs[selectedIndex].date, style: .date)
                        .font(.headline)

                    Text(logs[selectedIndex].date, style: .time)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()
            }
            .padding(.top)
        }
}

#Preview {
    CarouselPreview(logs: [])
}
