//
//  StatisticsView.swift
//  Crypto
//
//  Created by Sandesh on 08/11/25.
//

import SwiftUI

struct StatisticsView: View {
    
    let stat: StatisticsModel
    
    var body: some View {
        
        VStack(alignment: .center) {
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryTextColor)
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            
            HStack() {
                Image(systemName: "triangle.fill")
                    .rotationEffect(stat.percentageChange ?? 0 >= 0 ? Angle(degrees: 0) : Angle(degrees: 180))
                    .font(.caption)

                Text(stat.percentageChange?.asPercentageString() ?? "")
                    .font(.headline)
                    .bold()

            }
            .foregroundStyle(stat.percentageChange ?? 0 >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(stat.percentageChange == nil ? 0 : 1 )
                
        }
       
    }
}



struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView(stat: dev.stat1)
    }
}
