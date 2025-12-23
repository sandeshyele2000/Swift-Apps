//
//  CoinImageViewModel.swift
//  Crypto
//
//  Created by Sandesh on 27/09/25.
//

import Foundation
import SwiftUI
import Combine


// this just forwards the data fetched by service class

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coin: Coin
    private let dataService: CoinImageService
    
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.isLoading = true
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        // listening to changes made in image property of service class
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage // setting the value which actual view picks up
            }
            .store(in: &cancellables)
    }
    
}
