//
//  CurrencyRateRouter.swift
//  CurrencyTestApp
//
//  Created by makeev on 28.01.2019.
//

import Foundation
import UIKit

protocol CurrencyRateRouter {
}

class CurrencyRateRouterImpl: CurrencyRateRouter {
    
    //MARK: - Private properties
    
    private weak var navigationController: UINavigationController?
    private let serviceLocator: ServiceLocator
    
    
    //MARK: - Lifecycle
    
    init(navigationViewController: UINavigationController?, serviceLocator: ServiceLocator) {
        self.navigationController = navigationViewController
        self.serviceLocator = serviceLocator
    }
    
}
