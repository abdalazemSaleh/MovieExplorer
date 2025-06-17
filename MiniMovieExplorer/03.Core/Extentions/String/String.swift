//
//  String.swift
//  eTrip
//
//  Created by Abdalazem Saleh on 14/11/2024.
//

import UIKit

extension String {
    func trim() -> String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func localized(from tableName: LocalizationFiles, in bundle: Bundle = .main) -> String {
        return NSLocalizedString(self, tableName: tableName.rawValue, bundle: bundle, comment: "")
    }
    
    func localized(with args: CVarArg..., from tableName: LocalizationFiles) -> String {
        return String(format: self.localized(from: tableName), args)
    }
    
    func isValid(for type: ValidatorTypes) -> Bool {
        return Validator.validate(self, for: type)
    }
}
