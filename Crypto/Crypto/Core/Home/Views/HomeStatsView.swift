//
//  HomeStatsView.swift
//  Crypto
//
//  Created by Sandesh on 08/11/25.
//

import SwiftUI

struct HomeStatsView: View {
    
    
    @EnvironmentObject private var homeVm: HomeViewModel
    @Binding var showPortfolio: Bool

    var body: some View {

        HStack {
            ForEach(homeVm.statistics) { stat in
                StatisticsView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortfolio ? .trailing : .leading)
     
    }
}

struct HomeStatsView_PreviewProvider: PreviewProvider {
    static var previews: some View {
            HomeStatsView(showPortfolio: .constant(true))
            .environmentObject(dev.homeVM)
    }
}
