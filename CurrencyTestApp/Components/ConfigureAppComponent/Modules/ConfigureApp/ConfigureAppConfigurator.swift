import UIKit

protocol ConfigureAppConfigurator {
    func configureViewController(_ viewController: ConfigureAppViewController)
}

class ConfigureAppConfiguratorImpl: ConfigureAppConfigurator {
    func configureViewController(_ viewController: ConfigureAppViewController) {
        let router = ConfigureAppRouterImpl()
        let useCase = ConfigureDefaultAppUseCase()
        let presenter = ConfigureAppPresenterImpl(view: viewController, router: router, useCase: useCase)
        viewController.presenter = presenter
    }
}
