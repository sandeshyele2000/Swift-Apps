//
//  CoinImageView.swift
//  Crypto
//
//  Created by Sandesh on 27/09/25.
//

import SwiftUI

struct CoinImageView: View {
    
    @StateObject var vm: CoinImageViewModel
    
    init(coin: Coin) {
        // initialise view model which accepts params
        // Note: vm is get only property but it can be assigned using _vm
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.theme.secondaryTextColor)
            }
            
        }
    }
}

// image view -> view model -> service -> view model -> image view

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
    }
}
