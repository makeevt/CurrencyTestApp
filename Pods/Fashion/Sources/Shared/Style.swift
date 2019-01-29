/// Stylization closure wrapper.
public struct Style<T: Styleable> {
  let process: (T) -> Void

  // MARK: - Initialization

  public init(process: @escaping (_ view: T) -> Void) {
    self.process = process
  }

  // MARK: - Stylization

  /**
   Composes multiple styles.

   - Parameter styles: Styles to compose.
   - Returns: A new composed style.
   */
  public static func compose(_ styles: Style<T>...) -> Style<T> {
    return Style { view in
      for style in styles {
        style.apply(to: view)
      }
    }
  }

  /**
  Applies style to the passed view.

  - Parameter view: `Styleable` view.
  */
  public func apply(to view: T) {
    process(view)
  }

  /**
   Applies style to the passed view.

   - Parameter view: `Styleable` view.
   */
  public func apply(to views: T...) {
    for view in views {
      apply(to: view)
    }
  }

  /**
   Applies style to the passed view.

   - Parameter view: `Styleable` view.
   */
  func apply(to view: Styleable) {
    guard let view = view as? T else {
      return
    }

    process(view)
  }
}
