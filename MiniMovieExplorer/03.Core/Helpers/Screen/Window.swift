//
//  Window.swift
//  eTrip
//
//  Created by Abdalazem Saleh on 28/11/2024.
//

import UIKit

enum Window {
    static let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
    static let keyWindow = windowScene?.windows.first(where: { $0.isKeyWindow })
}
