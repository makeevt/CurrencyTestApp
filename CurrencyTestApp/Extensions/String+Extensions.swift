//
//  String+Extension.swift
//  CurrencyTestApp
//
//  Created by makeev on 28.01.2019.
//

import Foundation

public extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
