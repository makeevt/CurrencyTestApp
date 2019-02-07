//
//  CurrencyUpdateHelper.swift
//  CurrencyTestApp
//
//  Created by makeev on 29.01.2019.
//

import Foundation

protocol CurrencyUpdateHelperDelegate: class {
    func currencyUpdateHelper(_ currencyUpdateHelper: CurrencyUpdateHelper, didChangeCurrecies currencies: [String: CurrencyRateViewModel])
}

class CurrencyUpdateHelper {
    
    private struct Constants {
        static let updateInterval: TimeInterval = 1.0 // 1 second
        static let initialCurrencyType: CurrencyRateViewModel.CurrencyType = .eur
    }
    
    weak var delegate: CurrencyUpdateHelperDelegate?
    
    var currenciesArray: [CurrencyRateViewModel] {
        return self.currencies.values.sorted(by: {(cur1, cur2) in
            if cur1.type == self.currentBaseType {
                return true
            }
            if cur2.type == self.currentBaseType {
                return false
            }
            return cur1.type.shortName < cur2.type.shortName
        })
    }
    
    private var currentBaseType: CurrencyRateViewModel.CurrencyType
    private var currencies: [String: CurrencyRateViewModel]
    private var networkProvider: WebMobileAPIProvider
    private var updateTimer: DispatchSourceTimer? = nil
    private let helperQueue: DispatchQueue = DispatchQueue(label: "com.currency.currencyUpdateHelperQueue")
    
    init(provider: WebMobileAPIProvider) {
        self.networkProvider = provider
        let initialCurrency = CurrencyRateViewModel(type: Constants.initialCurrencyType, exchangeRate: 1.0)
        self.currentBaseType = initialCurrency.type
        self.currencies = [initialCurrency.type.rawValue: initialCurrency]
    }
    
    func startUpdateCurrency() {
        if self.updateTimer != nil {
            self.stopUpdateCurrency()
        }
        
        self.updateTimer = DispatchSource.makeTimerSource(flags: .strict, queue: DispatchQueue.global())
        self.updateTimer?.schedule(deadline: .now(), repeating: Constants.updateInterval)
        self.updateTimer?.setEventHandler { [weak self] in
            guard let self = self else { return }
            self.requestUpdate()
        }
        self.updateTimer?.resume()
    }
    
    func stopUpdateCurrency() {
        self.updateTimer?.cancel()
        self.updateTimer = nil
    }
    
    func recalculateExchangeResults(newAmount: Double) {
        self.helperQueue.async {
            for model in self.currencies.values {
                model.updateExchangeParameters(newAmount: newAmount)
            }
        }
    }
    
    func updateBaseCurrencyType(type: CurrencyRateViewModel.CurrencyType) {
        self.helperQueue.async {
            guard let currency = self.currencies[type.shortName] else {
                return
            }
            self.currentBaseType = type
            let newAmount = currency.exchangeResult
            
            for model in self.currencies.values {
                if model.type == type {
                    model.updateExchangeParameters(newRate: 1.0, newAmount: newAmount)
                    continue
                }
                let newRate = newAmount > 0 ? model.exchangeResult / newAmount : 0.0
                model.updateExchangeParameters(newRate: newRate, newAmount: newAmount)
            }
        }
    }
    
    private func requestUpdate() {
        self.networkProvider.request(.getCurrency(base: self.currentBaseType.shortName), successHandler: {[weak self] (result: NetworkCurrency) in
            guard let self = self else { return }
            guard self.currentBaseType.shortName == result.baseCurrency else {
                return
            }
            self.helperQueue.async {
                var hasNewCurrencies: Bool = false
                for rate in result.rates {
                    if let viewModel = self.currencies[rate.key] {
                        viewModel.updateExchangeParameters(newRate: rate.value)
                        continue
                    }
                    if let type = CurrencyRateViewModel.CurrencyType(rawValue: rate.key) {
                        self.currencies[rate.key] = CurrencyRateViewModel(type: type, exchangeRate: rate.value)
                        hasNewCurrencies = true
                    }
                }
                if hasNewCurrencies {
                    self.delegate?.currencyUpdateHelper(self, didChangeCurrecies: self.currencies)
                }
            }
            }, errorHandler: {error in
                print(error)
        })
    }
    
}
