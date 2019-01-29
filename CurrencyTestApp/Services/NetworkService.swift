//
//  NetworkService.swift
//  CurrencyTestApp
//
//  Created by makeev on 25.01.2019.
//

import Foundation
import Reachability

public protocol NetworkServiceDelegate {
    func networkService(_ networkService: NetworkService, didChangeNetworkReachable networkReachable: Bool)
}

public extension NetworkServiceDelegate {
    func networkService(_ networkService: NetworkService, didChangeNetworkReachable networkReachable: Bool) {}
}

public protocol NetworkService {
    var unauthorizedProvider: WebMobileAPIProvider {get}
    var isReachable: Bool {get}
    var delegate: MulticastDelegate<NetworkServiceDelegate> {get}
}

public class NetworkServiceImpl: NetworkService {
    
    private let reachability = Reachability()!
    private var isNetworkReachable: Bool
    
    public init() {
        self.isNetworkReachable = reachability.connection != .none
        configureReachibility()
    }
    
    // MARK:- Private methods
    
    private func configureReachibility() {
        reachability.whenReachable = { [weak self] _ in
            guard let `self` = self else { return }
            guard !self.isNetworkReachable else { return }
            
            self.isNetworkReachable = true
            self.delegate.invokeDelegates({ delegate in
                delegate.networkService(self, didChangeNetworkReachable: true)
            })
        }
        reachability.whenUnreachable = { [weak self] _ in
            guard let `self` = self else { return }
            guard self.isNetworkReachable else { return }
            
            self.isNetworkReachable = false
            self.delegate.invokeDelegates({ delegate in
                delegate.networkService(self, didChangeNetworkReachable: false)
            })
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start reachability notifier")
        }
    }
    
    // MARK:- NetworkService
    
    public lazy var unauthorizedProvider = WebMobileAPIProvider(authorizationType: .unauthorized)
    
    public var isReachable: Bool {
        return reachability.connection != .none
    }
    
    public var delegate = MulticastDelegate<NetworkServiceDelegate>()
    
}
