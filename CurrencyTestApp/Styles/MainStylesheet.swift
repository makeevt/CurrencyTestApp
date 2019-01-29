import UIKit
import Fashion

extension RawRepresentable where RawValue == String {
    var string: String { return "\(type(of:self))." + rawValue }
}

enum Styles {
    
    enum UINavigationBar: String, StringConvertible {
        case `default`
    }
    
}

struct MainStylesheet: Stylesheet {

    func define()
    {
        
        //MARK:- UINavigationBar
        
        register(Styles.UINavigationBar.default) { (navigationBar:UINavigationBar) in
            navigationBar.tintColor = UIColor.darkGray
            navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navigationBar.shadowImage = UIImage()
            
            navigationBar.titleTextAttributes              = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
                                                              NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                                                              NSAttributedString.Key.kern: 0.7]
            navigationBar.isTranslucent                    = false
            navigationBar.barTintColor                     = UIColor.white
            navigationBar.backgroundColor                  = UIColor.white
            navigationBar.backIndicatorImage               = UIImage(named: "navbar.icon.back")
            navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "navbar.icon.back")
        }
        
        //MARK:- Shared Styles
        
        share { (navBar:UINavigationBar) in
            navBar.apply(styles: Styles.UINavigationBar.default)
        }
    }
}
