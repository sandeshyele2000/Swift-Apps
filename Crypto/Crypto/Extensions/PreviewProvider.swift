//
//  PreviewProvider.swift
//  Crypto
//
//  Created by Sandesh on 20/09/25.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    
    // if this was public
    // some one could initialise this
    // hence private to restrict initialisation inside the class
    private init() {}
    
    let homeVM = HomeViewModel()
    
    
    let coin = Coin(
        id: "bitcoin",
        symbol: "BTC",
        name: "Bitcoin",
        image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png",
        currentPrice: 27650.34,
        marketCap: 520_000_000_000,
        fullyDilutedValuation: 580_000_000_000,
        marketCapRank: 1,
        totalVolume: 35_000_000_000,
        high24H: 28000.00,
        low24H: 27000.00,
        priceChange24H: -120.50,
        priceChangePercentage24H: -0.43,
        marketCapChange24H: -2_000_000_000,
        marketCapChangePercentage24H: -0.38,
        circulatingSupply: 18_900_000,
        totalSupply: 21_000_000,
        maxSupply: 21_000_000,
        ath: 69000.00,
        athChangePercentage: -59.96,
        athDate: "2021-11-10T14:24:11.849Z",
        atl: 67.81,
        atlChangePercentage: 40756.34,
        atlDate: "2013-07-06T00:00:00.000Z",
        lastUpdated: "2025-09-20T12:00:00.000Z",
        currentHoldings: 2.5
    )
    
    
    let stat1 = StatisticsModel(title: "Market Cap", value: "$1B", percentageChange: 10.0)
    let stat2 = StatisticsModel(title: "Total Volume", value: "$11Tr")

}
