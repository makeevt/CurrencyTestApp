//
//  ViewDispatcher.swift
//  CurrencyTestApp
//
//  Created by makeev on 28.01.2019.
//

import Foundation
import UIKit

class ViewDispatcher {
    
    static let shared = ViewDispatcher()
    
    var window: UIWindow!
    
    private init() { }
    
    func showRoot(viewController: UIViewController, animated: Bool) {
        window.rootViewController?.dismiss(animated: false, completion: nil)
        window.rootViewController = viewController
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {},
                          completion: nil)
    }
    
    func windowMakeKeyAndVisible() {
        self.window.makeKeyAndVisible()
    }
    
    func dismissAll() -> Bool {
        if let rootViewController = window.rootViewController {
            let presentedAnything = rootViewController.presentedViewController != nil
            rootViewController.dismiss(animated: false, completion: nil)
            return presentedAnything
        }
        return false
    }
    
    var currentPresentedController: UIViewController? {
        if var topController = window.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        } else {
            return nil
        }
    }
    
}
