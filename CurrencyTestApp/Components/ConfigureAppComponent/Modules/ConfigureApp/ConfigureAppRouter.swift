import Foundation
import UIKit

protocol ConfigureAppRouter {
    func showCurrencyRate(locator: ServiceLocator)
}

class ConfigureAppRouterImpl: ConfigureAppRouter {

    func showCurrencyRate(locator: ServiceLocator) {
        let vc = CurrencyRateViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        
        vc.configurator = CurrencyRateConfiguratorImpl(navigationController: navigationController, serviceLocator: locator)
        ViewDispatcher.shared.showRoot(viewController: navigationController, animated: true)
    }

}
