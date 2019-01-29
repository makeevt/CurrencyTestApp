//
//  NumberFormatterProvider.swift
//  CurrencyTestApp
//
//  Created by makeev on 29.01.2019.
//

import Foundation

public enum NumberFormatterType {
    case exchangeRate
}

class NumberFormatterProvider {
    
    static let shared = NumberFormatterProvider()
    
    private init() { }
    
    private var numberFormatters: [NumberFormatterType: NumberFormatter] = [:]
    
    func formatterFor(type: NumberFormatterType) -> NumberFormatter {
        
        if let formatter = numberFormatters[type] {
            return formatter
        }
        
        let formatter = NumberFormatter()
        switch type {
        case .exchangeRate:
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 3
            formatter.numberStyle = .decimal
            formatter.roundingMode = .down
            formatter.decimalSeparator = "."
            formatter.usesGroupingSeparator = false
        }
        numberFormatters[type] = formatter
        return formatter
    }
}
