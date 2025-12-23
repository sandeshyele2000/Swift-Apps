//
//  DetailViewModel.swift
//  Crypto
//
//  Created by Sandesh on 20/12/25.
//

import Foundation
import Combine


class DetailViewModel: ObservableObject {
    
    
    @Published var overviewStatistics: [StatisticsModel] = []
    @Published var addtionalStatistics: [StatisticsModel] = []
    @Published var coin: Coin
    
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map({ (coinDetailModel, coinModel) -> (overviewArray: [StatisticsModel], additionalArray: [StatisticsModel]) in
                
                let price = coinModel.currentPrice.asCurrencyWithSixDecimals()
                let pricePercentChange = coinModel.priceChangePercentage24H
                let priceStat = StatisticsModel(title: "Current Price", value: price, percentageChange: pricePercentChange)
                
                let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
                let marketCapStat = StatisticsModel(title: "Market Cap", value: marketCap, percentageChange: nil)
                
                let rank = "\(coinModel.rank)"
                let rankStat = StatisticsModel(title: "Rank", value: String(coinModel.rank ?? 0), percentageChange: nil)
                
                let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
                let volumeStat = StatisticsModel(title: "Volume", value: volume, percentageChange: nil)
                
                let overviewArray: [StatisticsModel] = [priceStat, marketCapStat, rankStat, volumeStat]
                    
                
                
                let high = coinModel.high24H?.asCurrencyWithSixDecimals() ?? "n/a"
                let highStat = StatisticsModel(title: "24h High", value: high)
                
                let low = coinModel.low24H?.asCurrencyWithSixDecimals() ?? "n/a"
                let lowStat = StatisticsModel(title: "24h Low", value: low)
                
                let priceChange = coinModel.priceChange24H?.asCurrencyWithSixDecimals() ?? "n/a"
                let pricePercentChange2 = coinModel.priceChangePercentage24H ?? 0.0
                
                let priceChangeStat = StatisticsModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange2)
                
                let marketCapChange24H = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "n/a")
                let marketCapPercentChange2 = coinModel.marketCapChangePercentage24H ?? 0.0
                let marketCapChangeStat = StatisticsModel(title: "24h Market Cap Change", value: marketCapChange24H, percentageChange: marketCapPercentChange2)
                
                
                let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
                let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime) minutes"
                let blockStat = StatisticsModel(title: "Block Time", value: blockTimeString)
                
                let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
                let hashingStat = StatisticsModel(title: "Hashing Algorithm", value: hashing)
                
                let additionalArray: [StatisticsModel] = [highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat]
                
                return (overviewArray, additionalArray)
                
            })
            .sink { [weak self] (returnedCoinDetails) in
                self?.overviewStatistics = returnedCoinDetails.overviewArray
                self?.addtionalStatistics = returnedCoinDetails.additionalArray
            }
            .store(in: &cancellables)
    }
    
}
