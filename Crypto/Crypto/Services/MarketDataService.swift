//
//  MarketDataService.swift
//  Crypto
//
//  Created by Sandesh on 08/11/25.
//

import Foundation
import Combine

class MarketDataService {
  
    @Published var marketData: MarketDataModel? = nil
        
    var marketDataSubscription: AnyCancellable?
        
    init() {
        getData()
    }
    
    func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketDataSubscription = NetworkManager.getData(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: NetworkManager.handleCompletion,
                receiveValue: { [weak self] (globalData) in
                    self?.marketData = globalData.data
                    self?.marketDataSubscription?.cancel()
                }
            )
    }
}
