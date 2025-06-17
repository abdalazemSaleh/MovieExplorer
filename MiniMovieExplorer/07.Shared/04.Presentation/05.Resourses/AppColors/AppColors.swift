//
//  AppColors.swift
//  AseerAlkotb
//
//  Created by Abdalazem Saleh on 03/02/2025.
//

import UIKit

enum AppColors {
    case primary
    case background
    case secoundryBackground
    case border
    case text
    case placeholderText
    case black
    case red
    case green
    case yellow
    case primaryWithAlpha(CGFloat)
    case primaryLight
    case gray
    case gray_1
    case gray_2
    
    func getColor() -> UIColor {
        switch self {
        case .primary:
            return .prime
        case .primaryLight:
            return .primaryLight
        case .border:
            return .border
        case .black:
            return .black
        case .gray:
            return .appGray
        case .gray_1:
            return .gray1
        case .gray_2:
            return .gray2
        default:
            return .red
        }
    }
    
    func getColorHex() -> UIColor {
        switch self {
        default:
            return UIColor(hexString: "#FF0000")
        }
    }
}

extension UIColor {
    static func appColor(_ color: AppColors) -> UIColor {
        return color.getColor()
    }
        
    static func appColor(hex color: AppColors) -> UIColor {
        return color.getColorHex()
    }
}

extension CGColor {
    static func appColor(_ color: AppColors) -> CGColor {
        return color.getColor().cgColor
    }
}
