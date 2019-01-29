import Foundation

protocol ConfigureAppUseCase {
    func constructServiceLocator() -> ServiceLocator
}

class ConfigureDefaultAppUseCase: ConfigureAppUseCase{
    
    func constructServiceLocator() -> ServiceLocator {
        let locator = DefaultServiceLocator()
        return locator
    }
}

