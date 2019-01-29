//
//  CurrencyRateConfigurator.swift
//  CurrencyTestApp
//
//  Created by makeev on 28.01.2019.
//

import Foundation
import UIKit

protocol CurrencyRateConfigurator {
    func configure(viewController: CurrencyRateViewController)
}

class CurrencyRateConfiguratorImpl: CurrencyRateConfigurator {
    private weak var navigationController: UINavigationController?
    private var serviceLocator: ServiceLocator!
    
    init(navigationController: UINavigationController?, serviceLocator: ServiceLocator) {
        self.navigationController = navigationController
        self.serviceLocator = serviceLocator
    }
    
    func configure(viewController: CurrencyRateViewController) {
        let router = CurrencyRateRouterImpl(navigationViewController: navigationController, serviceLocator: serviceLocator)
        let interactor = CurrencyRateInteractorImpl(serviceLocator: serviceLocator)
        let presenter = CurrencyRatePresenterImpl(view: viewController, router: router, interactor: interactor)
        viewController.presenter = presenter
        interactor.output = presenter
    }
}
