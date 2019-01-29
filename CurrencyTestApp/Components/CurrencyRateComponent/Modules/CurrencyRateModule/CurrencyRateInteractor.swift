//
//  CurrencyRateInteractor.swift
//  CurrencyTestApp
//
//  Created by makeev on 28.01.2019.
//

import Foundation

protocol CurrencyRateInteractorOutput: class {
    func currencyRateInteractor(_ interactor: CurrencyRateInteractor, didRecieveUpdatedCurrencies currencies: [CurrencyRateViewModel])
}

protocol CurrencyRateInteractor {
    func obtainCurrencies() -> [CurrencyRateViewModel]
    func selectBaseCurrency(currency: CurrencyRateViewModel)
    func recalculateCurrencyExchange(value: Double)
}

class CurrencyRateInteractorImpl: CurrencyRateInteractor {
    
    private let serviceLocator: ServiceLocator
    private let currencyUpdateHelper: CurrencyUpdateHelper
    
    weak var output: CurrencyRateInteractorOutput?
    
    init(serviceLocator: ServiceLocator) {
        self.serviceLocator = serviceLocator
        self.currencyUpdateHelper = CurrencyUpdateHelper(provider: self.serviceLocator.networkService.unauthorizedProvider)
        self.currencyUpdateHelper.delegate = self
        self.currencyUpdateHelper.startUpdateCurrency()
    }
    
    func obtainCurrencies() -> [CurrencyRateViewModel] {
        return self.currencyUpdateHelper.currenciesArray
    }
    
    func selectBaseCurrency(currency: CurrencyRateViewModel) {
        self.currencyUpdateHelper.updateBaseCurrencyType(type: currency.type)
    }
    
    func recalculateCurrencyExchange(value: Double) {
        self.currencyUpdateHelper.recalculateExchangeResults(newAmount: value)
    }
    
}

extension CurrencyRateInteractorImpl: CurrencyUpdateHelperDelegate {
    func currencyUpdateHelper(_ currencyUpdateHelper: CurrencyUpdateHelper, didChangeCurrecies currencies: [String : CurrencyRateViewModel]) {
        Thread.do_onMainThread {
            self.output?.currencyRateInteractor(self, didRecieveUpdatedCurrencies: currencyUpdateHelper.currenciesArray)
        }
    }
}
