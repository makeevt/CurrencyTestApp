//
//  Thread+Extensions.swift
//  CurrencyTestApp
//
//  Created by makeev on 29.01.2019.
//

import Foundation

extension Thread {
    class func do_onMainThread(block: @escaping ()->()) {
        if self.isMainThread {
            block()
        } else {
            DispatchQueue.main.async {
                block()
            }
        }
    }
}
