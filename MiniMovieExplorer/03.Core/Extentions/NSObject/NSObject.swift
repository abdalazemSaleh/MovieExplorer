//
//  NSObject.swift
//  eTrip
//
//  Created by Abdalazem Saleh on 01/12/2024.
//

import Foundation

extension NSObject {
    class var className: String {
        return "\(self)"
    }
    
    var jsonToString: String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    func cast<T: Any>(to type: T.Type) -> T? {
        return self as? T
    }
    
    func forceCast<T: Any>(to type: T.Type) -> T {
        return self as! T
    }
}
