import UIKit

enum FontName: String {
    case montserrat = "Montserrat"
    case bebasNeue = "BebasNeue"
}

enum FontWeight: String {
    case regular = "Regular"
    case medium = "Medium"
    case semiBold = "SemiBold"
    case bold = "Bold"
}

extension UIFont {
    static func main(weight: FontWeight = .regular, ofSize size: CGFloat) -> UIFont{
        return montserrat(weight: weight, ofSize: size)
    }
    
    static func montserrat(weight: FontWeight = .regular, ofSize size: CGFloat) -> UIFont {
        let fontName = "\(FontName.montserrat.rawValue)-\(weight.rawValue)"
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func bebasNeue(weight: FontWeight = .regular, ofSize size: CGFloat) -> UIFont {
        let fontName = "\(FontName.bebasNeue.rawValue)-\(weight.rawValue)"
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func printAllFonts() {
        for family in UIFont.familyNames {
            print("Family: \(family)")
            for fontName in UIFont.fontNames(forFamilyName: family) {
                print("  Font: \(fontName)")
            }
        }
    }
}
