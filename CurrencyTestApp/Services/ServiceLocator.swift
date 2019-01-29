//
//  ServiceLocator.swift
//  CurrencyTestApp
//
//  Created by makeev on 25.01.2019.
//

import Foundation

public protocol ServiceLocator {
    var networkService: NetworkService {get}
}

public class DefaultServiceLocator {
    private var networkServiceInternal: NetworkServiceImpl
    
    public init() {
        networkServiceInternal = NetworkServiceImpl()
    }

}

extension DefaultServiceLocator: ServiceLocator {
    public var networkService: NetworkService {
        return networkServiceInternal
    }
}
