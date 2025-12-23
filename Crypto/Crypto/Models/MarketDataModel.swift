//
//  MarketCapPercentage.swift
//  Crypto
//
//  Created by Sandesh on 08/11/25.
//

import Foundation


struct GlobalData: Codable {
    let data: MarketDataModel
}


struct MarketDataModel: Codable {
    
    let totalMarketCap, marketCapPercentage, totalVolume: [String: Double]
    let marketCapChangePercentage24HUSD: Double?
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case marketCapPercentage = "market_cap_percentage"
        case totalVolume = "total_volume"
        case marketCapChangePercentage24HUSD = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }

        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        
        return ""
    }
    
    var bitCoinDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "usd"}) {
            return item.value.asPercentageString()
        }
        
        return ""
    }
    
}
