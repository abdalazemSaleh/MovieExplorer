//
//  SafeArray.swift
//  eTrip
//
//  Created by Abdalazem Saleh on 27/11/2024.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return index >= 0 && index < count ? self[index] : nil
    }
}
