//
//  CoinDataService.swift
//  Crypto
//
//  Created by Sandesh on 21/09/25.
//

import Foundation
import Combine


class CoinDataService {
    
    @Published var allCoins: [Coin] = []
    
    var coinSubscription: AnyCancellable?
        
    init() {
        getAllCoins()
    }
    
    func getAllCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin&names=Bitcoin&symbols=btc&category=layer-1&price_change_percentage=1h") else { return }
        
        coinSubscription = NetworkManager.getData(url: url)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: NetworkManager.handleCompletion,
                receiveValue: { [weak self] (coins) in
                    self?.allCoins = coins
                    self?.coinSubscription?.cancel()
                }
            )
    }
}
