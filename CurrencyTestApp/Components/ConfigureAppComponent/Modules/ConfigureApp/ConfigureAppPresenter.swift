import Foundation

protocol ConfigureAppPresenter {
    func viewLoaded()
}


class ConfigureAppPresenterImpl: ConfigureAppPresenter {
    
    private let router: ConfigureAppRouter
    private let useCase: ConfigureAppUseCase
    private weak var viewController: ConfigureAppViewController?
    
    init(view: ConfigureAppViewController, router: ConfigureAppRouter, useCase: ConfigureAppUseCase) {
        self.viewController = view
        self.router = router
        self.useCase = useCase
    }
    
    func viewLoaded() {
        let locator = self.useCase.constructServiceLocator()
        self.router.showCurrencyRate(locator: locator)
    }
}
