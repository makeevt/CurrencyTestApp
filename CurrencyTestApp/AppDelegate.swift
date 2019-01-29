//
//  AppDelegate.swift
//  CurrencyTestApp
//
//  Created by makeev on 25.01.2019.
//

import UIKit
import Fashion
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        Fashion.register(stylesheets: [MainStylesheet()])
        IQKeyboardManager.shared.enable = true

        let window = UIWindow(frame: UIScreen.main.bounds)
        ViewDispatcher.shared.window = window

        let viewController = ConfigureAppViewController()
        let configurator = ConfigureAppConfiguratorImpl()
        configurator.configureViewController(viewController)
        window.rootViewController = viewController
        
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }

}
