//
//  CoinImageService.swift
//  Crypto
//
//  Created by Sandesh on 27/09/25.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage?
    
    private var imageSubscription: AnyCancellable?
    private let coin: Coin
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: Coin) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: coin.id, folderName: folderName) {
            image = savedImage
        } else {
            downloadCoinImage()
        }
            
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        imageSubscription = NetworkManager.getData(url: url)
            .sink(
                receiveCompletion: NetworkManager.handleCompletion,
                receiveValue: { [weak self] (returnedImage) in
                    let returnedImage = UIImage(data: returnedImage);
                    guard let self = self, let downloadImage = returnedImage else { return }
                   
                    self.image = downloadImage
                    self.imageSubscription?.cancel()
                    self.fileManager.saveImage(image: downloadImage, imageName: self.imageName, folderName: self.folderName)
                }
            )
    }
}
