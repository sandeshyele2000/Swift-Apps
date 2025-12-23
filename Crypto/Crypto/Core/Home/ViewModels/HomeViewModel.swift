//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Sandesh on 20/09/25.
//

import Foundation
import Combine


class HomeViewModel: ObservableObject {

    @Published var statistics: [StatisticsModel] = []
    
    @Published var allCoins: [Coin] = []
    @Published var porfolioCoins: [Coin] = []
    @Published var searchText: String = ""
    @Published var sortOption: SortOptions = .holdings
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var isLoading = false;
    
    
    init() {
       addSubscribers()
    }
    
    enum SortOptions {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    func addSubscribers() {
        // subscribed to any change in allCoins variable
        coinDataService.$allCoins
            .sink { [weak self] allCoins in
                self?.allCoins = allCoins
            }
            .store(in: &cancellables)
        
        // subscribed to any change in searchText update all coins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .map { (text, startingCoins, sortOption) -> [Coin] in
                
                guard !text.isEmpty else {
                    return startingCoins
                }
                
                
                let lowercasedText = text.lowercased()
                var filteredCoins =  startingCoins.filter { (coin) -> Bool in
                    return coin.id.lowercased().contains(lowercasedText)
                            || coin.name.lowercased().contains(lowercasedText)
                    || coin.symbol.lowercased().contains(lowercasedText)
                    
                }
                
                self.sortCoins(coins: &filteredCoins, sortOption: sortOption)
                
                return filteredCoins
                
            }
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables) // keeps the subscription alive.
        
        // portfolio update
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map { (coins, savedEntities) -> [Coin] in
                coins.compactMap { (coin) -> Coin? in
                    guard let entity = savedEntities.first(where: {$0.coinID == coin.id}) else {
                        return nil
                    }
                    
                    return coin.updateHoldings(amount: entity.amount)
                    
                }
            }
            .sink { [weak self] (returnedCoins) in
                guard let self = self else { return }
                self.porfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        marketDataService.$marketData
            .combineLatest($porfolioCoins)
            .map{ (marketDataModel, portfolioCoins) -> [StatisticsModel] in
            
                 var stats: [StatisticsModel] = []
                 
                 guard let data = marketDataModel else {
                    return stats
                 }
                 
                let marketCap = StatisticsModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUSD)
                let btcDominance = StatisticsModel(title: "BTC Dominance", value: data.bitCoinDominance)
                let volume = StatisticsModel(title: "Volume", value: data.volume)
                
               
                
                let portfolioValue = portfolioCoins
                    .map({ $0.currentHoldingsValue })
                    .reduce(0, +)
                    
          
                let previousValue =
                    portfolioCoins
                        .map { coin -> Double in
                            let currentValue = coin.currentHoldingsValue
                            let percentChange = coin.priceChangePercentage24H ?? 0.0
                            return currentValue / (1 + percentChange)
                        }
                        .reduce(0, +)
                
                let percentageValue = ((portfolioValue - previousValue) / previousValue) * 100
                
                let portfolio = StatisticsModel(title: "Portfolio Value", value: "$\(portfolioValue.formattedWithAbbreviations())", percentageChange: percentageValue)
                
                
                
                stats.append(contentsOf: [
                    marketCap,
                    volume,
                    btcDominance,
                    portfolio
                ])
                
                return stats
            }.sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
            }.store(in: &cancellables)
    }
    
    
    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getAllCoins()
        marketDataService.getData()
        isLoading = false
        HapticManager.notification(type: .success)
    }
    
    func sortCoins(coins: inout [Coin], sortOption: SortOptions) {
        
        switch sortOption {
        case .rank, .holdings:
            coins.sort { (coin1, coin2) -> Bool in
                return coin1.rank < coin2.rank
            }
        case .rankReversed, .holdingsReversed:
            coins.sort { (coin1, coin2) -> Bool in
                return coin1.rank > coin2.rank
            }
        case .price:
            coins.sort { (coin1, coin2) -> Bool in
                return coin1.currentPrice < coin2.currentPrice
            }
        case .priceReversed:
            coins.sort { (coin1, coin2) -> Bool in
                return coin1.currentPrice > coin2.currentPrice
            }
        }
    }
    
    func sortPortfolioCoinsIfNeeded(coins: [Coin]) -> [Coin] {
        switch sortOption {
        case .holdings:
            return coins.sorted { (coin1, coin2) -> Bool in
                coin1.currentHoldingsValue > coin2.currentHoldingsValue
            }
        case .holdingsReversed:
            return coins.sorted { (coin1, coin2) -> Bool in
                coin1.currentHoldingsValue < coin2.currentHoldingsValue
            }
            
        default:
            return coins
        }
    }
    
}
