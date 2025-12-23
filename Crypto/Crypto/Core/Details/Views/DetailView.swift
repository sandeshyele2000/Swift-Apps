//
//  DetailView.swift
//  Crypto
//
//  Created by Sandesh on 16/12/25.
//

import SwiftUI



struct DetailLoadingView: View {
    @Binding var coin: Coin?
    
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
            
        }
    }

}


struct DetailView: View {
    @StateObject var vm: DetailViewModel
    @State private var isRotating = false

    private let imageService: CoinImageService
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let spacing: CGFloat = 30
    
    init(coin: Coin) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        self.imageService = CoinImageService(coin: coin)
    }
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let coinImage = imageService.image {
                    Image(uiImage: coinImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .rotation3DEffect(Angle(degrees: (isRotating ? 360 : 0)), axis: (x: 0, y:1, z: 0))
                        .animation(
                            .linear(duration: 4)
                                .repeatForever(autoreverses: false),
                            value: isRotating
                        )
                        .onAppear {
                            isRotating = true
                        }
                }
                Text("Overview")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
                LazyVGrid(
                    columns: columns,
                    alignment: .center,
                    spacing: spacing,
                    pinnedViews: [],
                    content: {
                        ForEach(vm.overviewStatistics) { stat in
                            StatisticsView(stat: stat)
                        }
                    } 
                )
                Text("Addtional Details")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                LazyVGrid(
                    columns: columns,
                    alignment: .center,
                    spacing: spacing,
                    pinnedViews: [],
                    content: {
                        ForEach(vm.addtionalStatistics) { stat in
                            StatisticsView(stat: stat)
                        }
                    }
                )
                    
                
            }.padding()
            
        }.navigationTitle("\(vm.coin.name)")
    }
}


struct DetailViewPreviewProvider: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}
