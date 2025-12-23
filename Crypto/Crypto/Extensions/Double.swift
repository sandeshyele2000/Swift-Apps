//
//  Double.swift
//  Crypto
//
//  Created by Sandesh on 20/09/25.
//

import Foundation

extension Double {
    
    /// Converts a Double to currency upto 2-6 decimal places
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// Convert 12.34 to $12.34
    /// Convert 0.34 to $0.34
    ///  ```
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    
    /// Converts a Double to currency upto 2-6 decimal places
    /// ```
    /// Convert 1234.56 to "$1,234.56"
    /// Convert 12.3456 to "$12.3456"
    /// Convert 0.3467 to "$0.3467"
    ///  ```
    
    func asCurrencyWithSixDecimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter.string(from: number) ?? "0.00"
    }
    
    
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    func asPercentageString() -> String {
        return asNumberString() + "%"
    }
    
    func formattedWithAbbreviations() -> String {
        let num = abs(self)
        let sign = self < 0 ? "-" : ""

        switch num {

        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            return "\(sign)\(formatted.asNumberString())T"

        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            return "\(sign)\(formatted.asNumberString())B"

        case 1_000_000...:
            let formatted = num / 1_000_000
            return "\(sign)\(formatted.asNumberString())M"

        case 1_000...:
            let formatted = num / 1_000
            return "\(sign)\(formatted.asNumberString())K"

        default:
            return self.asNumberString()
        }
    }
    
}
