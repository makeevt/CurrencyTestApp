import Foundation
open class MulticastDelegate<T> {
    
    private var lock = DispatchSemaphore(value: 1)
    private var delegates = NSHashTable<AnyObject>.weakObjects()
    
    public var isEmpty: Bool {
        var result: Bool
        lock.wait()
        result = delegates.count == 0
        lock.signal()
        return result
    }
    
    // MARK:- Lifecycle
    
    public init() {} 
    
    // MARK:- Public methods
    
    public func addDelegate(_ delegate: T) {
        lock.wait()
        if !delegates.contains(delegate as AnyObject) {
            delegates.add(delegate as AnyObject)
        }
        lock.signal()
    }
    
    public func removeDelegate(_ delegate: T) {
        lock.wait()
        delegates.remove(delegate as AnyObject)
        lock.signal()
    }
    
    public func invokeDelegates(_ invocation: (T) -> ()) {
        lock.wait()
        let delegates = self.delegates.allObjects
        lock.signal()
        for delegate in delegates {
            invocation(delegate as! T)
        }
    }
    
    public func containsDelegate(_ delegate: T) -> Bool {
        var result: Bool
        lock.wait()
        result = delegates.contains(delegate as AnyObject)
        lock.signal()
        return result
    }
    
}
