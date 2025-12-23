//
//  CoinDetailDataService.swift
//  Crypto
//
//  Created by Sandesh on 20/12/25.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    @Published var coinDetails: CoinDetail? = nil
    let coin: Coin
    var coinSubscription: AnyCancellable?
    
        
    init(coin: Coin) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)") else { return }
        
        coinSubscription = NetworkManager.getData(url: url)
            .decode(type: CoinDetail.self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: NetworkManager.handleCompletion,
                receiveValue: { [weak self] (receivedCoinDetails) in
                    self?.coinDetails = receivedCoinDetails
                    self?.coinSubscription?.cancel()
                }
            )
    }
}
