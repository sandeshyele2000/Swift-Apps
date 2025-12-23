//
//  CoinRowView.swift
//  Crypto
//
//  Created by Sandesh on 20/09/25.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: Coin
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing: 0){
            leftSection
            Spacer()
            if showHoldingsColumn {
                centerSection
            }
            rightSection
        }.background(
            Color.theme.background.opacity(0.01)
        )
    }
}


extension CoinRowView {
    
    private var centerSection: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWithSixDecimals()).bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundStyle(Color.theme.accent)
    }
    
    private var rightSection: some View {
        VStack(alignment: .trailing) {
            Text("\(coin.currentPrice.asCurrencyWithSixDecimals())")
                .bold()
                .foregroundStyle(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentageString() ?? "")
                .foregroundStyle((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
    
    private var leftSection: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .frame(minWidth: 30)
                .foregroundStyle(Color.theme.secondaryTextColor)
            CoinImageView(coin: coin)
                .frame(width: 20, height: 20)
                .foregroundColor(.gray)
            Text("\(coin.symbol.uppercased())")
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.theme.accent)
        }
    }
}


struct CoinRowView_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
