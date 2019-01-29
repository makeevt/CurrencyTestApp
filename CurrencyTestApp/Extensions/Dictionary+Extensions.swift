//
//  Dictionary+Extensions.swift
//  CurrencyTestApp
//
//  Created by makeev on 29.01.2019.
//

import Foundation

extension Dictionary {
    
    func contains(key: Key) -> Bool {
        let value = self.contains { (k,_) -> Bool in key == k }
        return value
    }
    
}
