import UIKit

enum AppTheme {
    case light
    case dark
}

struct Theme {
    static func currentTheme() -> AppTheme {
        if UITraitCollection.current.userInterfaceStyle == .dark {
            return .dark
        } else {
            return .light
        }
    }
    
    static func isDarkMode() -> Bool {
        return currentTheme() == .dark
    }
}
