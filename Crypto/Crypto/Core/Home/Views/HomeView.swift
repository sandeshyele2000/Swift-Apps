//
//  HomeView.swift
//  Crypto
//
//  Created by Sandesh on 20/09/25.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    
    @State private var showPortfolioView: Bool = false
    
    @State private var selectedCoin: Coin? = nil
    @State private var showDetailView: Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    // sheets create a new environment
                    // so we need add env view model explicitly
                    PortfolioView()
                        .environmentObject(vm)
                })
            
            VStack {
                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                titleSection
                if !showPortfolio {
                    livePricesList
                        .transition(.move(edge: .leading))
                } else {
                    portfolio
                        .transition(.move(edge: .trailing))
                }
                Spacer()
            }
        }.navigationDestination(isPresented: $showDetailView) {
            DetailLoadingView(coin: $selectedCoin)
        }
    }
}


struct HomeView_Preview : PreviewProvider {
    
    static var previews: some View {
        NavigationStack(){
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
        
    }
}


extension HomeView {
    
    private var titleSection: some View {
        HStack {
            
            HStack {
                Text("Coins")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0: 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0: 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            
            if showPortfolio {
                HStack {
                    Text("Holdings")
                        .font(.caption)
                        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0: 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0: 180))
                    
                }
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
                
            }
            
            Spacer()
            HStack {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .priceReversed || vm.sortOption == .price) ? 1.0: 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0: 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
            
            Button(action: {
                withAnimation(.easeIn(duration: 2.0)) {
                    vm.reloadData()
                }
                
            }, label: {
                Image(systemName: "goforward")
            })
            .rotationEffect(Angle(degrees: vm.isLoading ? 360: 0), anchor: .center)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryTextColor)
        .padding()
    }
    
    private func segue(coin: Coin) {
        selectedCoin = coin
        showDetailView.toggle()
    }
    
    private var livePricesList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(
                        top: 10,
                        leading: 0,
                        bottom: 10,
                        trailing: 10
                    ))
                    .onTapGesture {
                        segue(coin: coin)
                    }

            }
        }
        .listStyle(PlainListStyle())
    }
    
    
    private var portfolio: some View {
        List {
            ForEach(vm.porfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(
                        top: 10,
                        leading: 0,
                        bottom: 10,
                        trailing: 10
                    ))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
        
    }
    
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus": "info")
                .transaction { t in t.animation = nil } // to disable default animation
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
                .background {
                    CircleButtonAnimationView(animate: $showPortfolio)
                }
            Spacer()
            Text(showPortfolio ? "Portfolio" :"Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180: 0 ))
                .onTapGesture {
                    withAnimation(.spring) {
                        showPortfolio.toggle()
                    }
                }
        }
    }
}
