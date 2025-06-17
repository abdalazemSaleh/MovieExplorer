//
//  UserDefultsWrapped.swift
//  eTrip
//
//  Created by Abdalazem Saleh on 03/12/2024.
//

import Foundation

struct UserDefultsWrapped {
    @UserDefaultsWrapper(key: "isFirstLaunch", defaultValue: true)
    static var isFirstLaunch: Bool
}
