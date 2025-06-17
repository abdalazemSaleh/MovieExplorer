//
//  Validator.swift
//  eTrip
//
//  Created by Abdalazem Saleh on 18/11/2024.
//

import Foundation

enum ValidatorTypes: Int {
    case non = 0
    case name = 1
    case phone = 2
    case email = 3
    case password = 4
    case confirmPassword = 5
    case emptyField = 6
    
    var errorMessage: String {
        switch self {
        case .name:
            "name.validation".localized(from: .MainApp)
        case .email:
            "email.validation".localized(from: .MainApp)
        case .phone:
            "phone.validation".localized(from: .MainApp)
        case .password:
            "password.validation".localized(from: .MainApp)
        case .emptyField:
            "empty_password.validation".localized(from: .MainApp)
        case .confirmPassword:
            "confirm_password.validation".localized(from: .MainApp)
        case .non:
            ""
        }
    }
    
    var maxLength: Int {
        switch self {
        case .name:
            50
        case .email:
            254
        case .phone:
            9
        case .password:
            100
        default:
            256
        }
    }
}

class Validator {
    static func pattern(for type: ValidatorTypes) -> String {
        switch type {
        case .name:
            return "^[a-zA-Z\\u0600-\\u06FF\\s]{4,50}$"
        case .email:
            return "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        case .phone:
            return "^1[0125][0-9]{8}$"
        case .password:
            return "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^A-Za-z0-9])[A-Za-z\\d[^A-Za-z0-9]]{8,}$"
        case .emptyField:
            return "^.{1,}$"
            
        default: return ""
        }
    }
    
    static func validate(_ input: String, for type: ValidatorTypes) -> Bool {
        let pattern = self.pattern(for: type)
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: input.utf16.count)
        return regex?.firstMatch(in: input, options: [], range: range) != nil
    }
}

