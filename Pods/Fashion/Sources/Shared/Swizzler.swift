import Foundation

/**
 A helper struct for method swizzling.
 */
struct Swizzler {
  /**
   Swizzles method by name.

   - parameter method: Method
   - parameter cls: Class
   - parameter prefix: Unique prefix
   - parameter prefix: Swizzling type, instance or class
  */
  static func swizzle(cls: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
    let originalMethod = class_getInstanceMethod(cls, originalSelector)
    let swizzledMethod = class_getInstanceMethod(cls, swizzledSelector)
    method_exchangeImplementations(originalMethod!, swizzledMethod!)
  }
}

/**
 DispatchQueue extension which implements dispatch_once functionality
 */
extension DispatchQueue {
  private static var tokens = [String]()

  /**
   Executes a closure only once.

   - parameter token: A unique token
   - parameter closure: Closure to execute once
   */
  class func once(token: String, closure: () -> Void) {
    objc_sync_enter(self)

    defer {
      objc_sync_exit(self)
    }

    guard !tokens.contains(token) else {
      return
    }

    tokens.append(token)
    closure()
  }
}
