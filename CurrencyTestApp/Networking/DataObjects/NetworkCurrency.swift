//
//  NetworkCurrency.swift
//  CurrencyTestApp
//
//  Created by makeev on 29.01.2019.
//

import Foundation
import ObjectMapper

class NetworkCurrency: ImmutableMappable {
    
    let baseCurrency: String
    let rates: [String: Double]
    
    required init(map: Map) throws {
        baseCurrency = try map.value("base")
        rates = try map.value("rates")
    }
}
