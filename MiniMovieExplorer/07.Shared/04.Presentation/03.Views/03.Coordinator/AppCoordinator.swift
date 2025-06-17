//
//  AppCoordinator.swift
//  eTrip
//
//  Created by Abdalazem Saleh on 07/10/2024.
//

import UIKit

class AppCoordinator {
    
    var windo: UIWindow?
    var isLogin = false
    
    @Injected var router: Router
    
    static let shared = AppCoordinator()
    
    init() {
        router.navigationController.isNavigationBarHidden = true
    }
}

// MARK: - Main Coordinatot
extension AppCoordinator: Coordinator {
    func makeWindow(from windoScene: UIWindowScene) {
        let windo = UIWindow(windowScene: windoScene)
        windo.rootViewController = self.router.navigationController
        windo.makeKeyAndVisible()
        self.windo = windo
    }
    
    func resetWindo() {
        guard let window = windo else { return }
        window.rootViewController = self.router.navigationController
        window.makeKeyAndVisible()
        self.windo = window
    }
    
    func start() {
//        showSplash()
        showHome()
    }
    
    func showSplash() {
        let vc = SplashVC()
        router.push(vc)
    }
    
    func showHome() {
        guard let window = windo else { return }
        UIView.transition(with: window, duration: 1, options: .transitionFlipFromRight) {
            self.resetWindo()
        }
        let coordinator = HomeCoordinator()
        coordinator.start()
    }
}
