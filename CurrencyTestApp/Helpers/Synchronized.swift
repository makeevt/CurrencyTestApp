//
//  Synchronized.swift
//  CurrencyTestApp
//
//  Created by makeev on 29.01.2019.
//

import Foundation

public class Synchronized<T> {
    private var lock = DispatchSemaphore(value: 1)
    private var didSetClosure: ((_ oldValue: T, _ newValue: T) -> ())?
    private var synсedValue: T {
        didSet {
            didSetClosure?(oldValue, synсedValue)
        }
    }
    public var value: T {
        set {
            lock.wait()
            synсedValue = newValue
            lock.signal()
        }
        get {
            let result: T
            lock.wait()
            result = synсedValue
            lock.signal()
            return result
        }
    }
    
    // MARK:- Lifecycle
    
    public init(value: T) {
        synсedValue = value
    }
    
    // MARK:- Public methods
    
    public func setDidSetClosure(_ closure: @escaping ((_ oldValue: T, _ newValue: T) -> ())) {
        didSetClosure = closure
    }
    
    public func execute(_ block: (inout T)->()) {
        lock.wait()
        block(&synсedValue)
        lock.signal()
    }
}
