//
//  FontName.swift
//  MiniMovieExplorer
//
//  Created by Abdel Azim Saleh on 16/06/2025.
//

import UIKit

enum FontName: String {
    case urwdina = "URWDINArabic"
    case tajawal = "Tajawal"
    case neoSans = "NeoSansArabic"
    case sans = "Sans"
}

enum FontWeight: String {
    case regular = "Regular"
    case medium = "Medium"
    case semiBold = "Demi"
    case bold = "Bold"
}

extension UIFont {
    static func main(weight: FontWeight = .regular, ofSize size: CGFloat) -> UIFont{
        return udwdina(weight: weight, ofSize: size)
    }
    
    static func udwdina(weight: FontWeight = .regular, ofSize size: CGFloat) -> UIFont {
        let fontName = "\(FontName.urwdina.rawValue)-\(weight.rawValue)"
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func tajawal(weight: FontWeight = .regular, ofSize size: CGFloat) -> UIFont {
        let fontName = weight == .regular ? FontName.neoSans.rawValue : "\(FontName.neoSans.rawValue)-\(weight.rawValue)"
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
