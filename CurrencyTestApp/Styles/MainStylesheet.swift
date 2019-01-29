import UIKit
import Fashion

extension RawRepresentable where RawValue == String {
    var string: String { return "\(type(of:self))." + rawValue }
}

enum Styles {
    
    enum UINavigationBar: String, StringConvertible {
        case `default`
    }
    
    enum ELDTextField: String, StringConvertible {
        case dark
        case light
        case logInfo
        case forLogsComponent
    }
    
}

struct MainStylesheet: Stylesheet {
    
    private struct Constants {
        static let borderWidth = 1.0
        static let cornerRadius = 4.0
    }

    func define()
    {
        //MARK:- General
        

        
        //MARK:- ELDButton
        
//        register(Styles.ELDButton.primary) { (button:ELDButton) in
//            button.apply(styles: Styles.General.roundCorners)
//            
//            // Normal
//            button.setBackgroundColor(UIColor.eiAzureTwo,      for: .normal)
//            button.setTitleColor(UIColor.eiWhite,              for: .normal)
//            // Highlighted
//            button.setBackgroundColor(UIColor.eiTurquoiseBlue, for: .highlighted)
//            button.setTitleColor(UIColor.eiWhite,              for: .highlighted)
//            // Disabled
//            button.setBackgroundColor(UIColor.eiAzureTwo.withAlphaComponent(0.4), for: .disabled)
//            button.setTitleColor(UIColor.eiWhite.withAlphaComponent(0.4),         for: .disabled)
//            
//            button.titleLabel?.font = UIFont.mediumAzoSansFont(ofSize: 16)
//        }
        
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
