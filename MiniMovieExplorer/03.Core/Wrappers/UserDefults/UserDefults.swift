//
//  UserDefults.swift
//  eTrip
//
//  Created by Abdalazem Saleh on 03/12/2024.
//

import Foundation

import Foundation

@propertyWrapper
struct UserDefaultsWrapper<T> {
    private let key: String
    private let defaultValue: T
    private let userDefaults: UserDefaults

    init(key: String, defaultValue: T, userDefaults: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
    }

    var wrappedValue: T {
        get {
            userDefaults.object(forKey: key) as? T ?? defaultValue
        }
        set {
            userDefaults.set(newValue, forKey: key)
        }
    }
}
