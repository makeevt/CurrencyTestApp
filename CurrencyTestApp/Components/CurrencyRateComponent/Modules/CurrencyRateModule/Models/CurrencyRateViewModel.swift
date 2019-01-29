//
//  CurrencyRateViewModel.swift
//  CurrencyTestApp
//
//  Created by makeev on 28.01.2019.
//

import Foundation
import UIKit

protocol CurrencyRateViewModelDelegate: class {
    func currencyRateViewModel(_ model: CurrencyRateViewModel, didUpdateExchangeResult result: Double)
}

class CurrencyRateViewModel {
    
    typealias CurrecyExchangeParameters = (rate: Double, amount: Double)
    
    enum CurrencyType: String, CaseIterable {
        case eur = "EUR"
        case aud = "AUD"
        case bgn = "BGN"
        case brl = "BRL"
        case cad = "CAD"
        case chf = "CHF"
        case cny = "CNY"
        case czk = "CZK"
        case dkk = "DKK"
        case gbp = "GBP"
        case hkd = "HKD"
        case hrk = "HRK"
        case huf = "HUF"
        case idr = "IDR"
        case ils = "ILS"
        case inr = "INR"
        case isk = "ISK"
        case jpy = "JPY"
        case krw = "KRW"
        case mxn = "MXN"
        case myr = "MYR"
        case nok = "NOK"
        case nzd = "NZD"
        case php = "PHP"
        case pln = "PLN"
        case ron = "RON"
        case rub = "RUB"
        case sek = "SEK"
        case sgd = "SGD"
        case thb = "THB"
        case `try` = "TRY"
        case usd = "USD"
        case zar = "ZAR"
        
        var image: UIImage? {
            return UIImage(named: self.rawValue.lowercased())
        }
        
        var shortName: String {
            return self.rawValue
        }
        
        var fullLocalizedName: String {
            return "currencyType.fullName.\(self.rawValue.lowercased())".localized
        }
    }
    
    weak var delegate: CurrencyRateViewModelDelegate?
    
    let type: CurrencyType
    var exchangeResult: Double {
        let params = self.exchangeParameters.value
        return params.rate * params.amount
    }
    
    private var exchangeParameters: Synchronized<CurrecyExchangeParameters>
    
    init(type: CurrencyType, exchangeRate: Double) {
        self.type = type
        self.exchangeParameters = Synchronized(value: (exchangeRate, 1.0))
    }
    
    func updateExchangeParameters(newRate: Double? = nil, newAmount: Double? = nil) {
        let rate = newRate ?? self.exchangeParameters.value.rate
        let amount = newAmount ?? self.exchangeParameters.value.amount
        self.exchangeParameters.value = (rate, amount)
        self.delegate?.currencyRateViewModel(self, didUpdateExchangeResult: self.exchangeResult)
    }
    
}
