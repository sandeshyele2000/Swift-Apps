//
//  PortfolioView.swift
//  Crypto
//
//  Created by Sandesh on 07/12/25.
//

import SwiftUI

struct PortfolioView: View {
    
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject private var vm: HomeViewModel
    
    @State private var selectedCoin: Coin? = nil
    
    @State var quantityText: String = ""
    
    @State var showCheckMark: Bool = false

    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                    
                }
                
            }
            .navigationTitle("Edit Portfolio")
            .onChange(of: vm.searchText) { (oldValue, newValue) in
                if newValue.isEmpty {
                    removeSelectedCoin()
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    
                    HStack {
                        Image(systemName: "checkmark").opacity(showCheckMark ? 1 : 0)

                        Button {
                            saveButtonPressed()
                        } label: {
                            Text("Save".uppercased())
                            
                        }.opacity((selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1: 0)
                    }
                    
                }
            }
        }
    }
    
}

struct Portfolio_Preview : PreviewProvider {
    
    static var previews: some View {
        NavigationView(){
            PortfolioView()
        }
        .environmentObject(dev.homeVM)
        
    }
}


extension PortfolioView {
    var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.searchText.isEmpty ? vm.porfolioCoins : vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    selectedCoin?.id == coin.id ? Color.theme.green : Color.clear
                                )
                        }.onTapGesture {
                            withAnimation {
                                updateSelectedCoin(coin: coin)
                            }

                        }
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        }
    }
    
    private func updateSelectedCoin(coin: Coin) {
        selectedCoin = coin
        
        if let portfolioCoin = vm.porfolioCoins.first(where: { $0.id == coin.id }),
        let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
        
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity*(selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func saveButtonPressed() {
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
        else { return }
        
        // save coin
        vm.updatePortfolio(coin: coin, amount: amount)
        
        withAnimation(.easeIn) {
            showCheckMark = true
            removeSelectedCoin()
        }
        
        // dismiss keyboard
        UIApplication.shared.endEditing()
        
        // hide check mark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeInOut) {
                showCheckMark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current Price of \(selectedCoin?.name ?? ""):")
                Spacer()
                Text("\(selectedCoin?.currentPrice.asCurrencyWithSixDecimals() ?? ""):")
                
            }
            Divider()
            HStack {
                Text("Amount in your portfolio:")
                Spacer()
                TextField("ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                
            }
            Divider()
            HStack {
                Text("Current Value of \(selectedCoin?.name ?? ""):")
                Spacer()
                Text(getCurrentValue().asCurrencyWithSixDecimals())
                
            }
        }
        .padding()
    }
}
