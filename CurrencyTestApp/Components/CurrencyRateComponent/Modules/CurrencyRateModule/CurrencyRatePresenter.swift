//
//  CurrencyRatePresenter.swift
//  CurrencyTestApp
//
//  Created by makeev on 28.01.2019.
//

import Foundation

protocol CurrencyRateView: class {
    func configure(viewModels: [CurrencyRateViewModel])
}

protocol CurrencyRatePresenter: class {
    func didTriggerViewReadyEvent()
    func didTriggerCurrencyExchangeValueChanged(value: Double)
    func didTriggerCurrencySelected(currency: CurrencyRateViewModel)
}

class CurrencyRatePresenterImpl: CurrencyRatePresenter {
    
    private weak var view: CurrencyRateView?
    private var router: CurrencyRateRouter
    private var interactor: CurrencyRateInteractor
    
    
    init(view: CurrencyRateView, router: CurrencyRateRouter, interactor: CurrencyRateInteractor) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func didTriggerViewReadyEvent() {
        let currencies = self.interactor.obtainCurrencies()
        self.view?.configure(viewModels: currencies)
    }
    
    func didTriggerCurrencySelected(currency: CurrencyRateViewModel) {
        self.interactor.selectBaseCurrency(currency: currency)
    }
    
    func didTriggerCurrencyExchangeValueChanged(value: Double) {
        self.interactor.recalculateCurrencyExchange(value: value)
    }
}

extension CurrencyRatePresenterImpl: CurrencyRateInteractorOutput {
    func currencyRateInteractor(_ interactor: CurrencyRateInteractor, didRecieveUpdatedCurrencies currencies: [CurrencyRateViewModel]) {
        self.view?.configure(viewModels: currencies)
    }
}
