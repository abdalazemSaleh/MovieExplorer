import UIKit

class AppCoordinator {
    
    var windo: UIWindow?
    var isLogin = false
    
    var router: Router
    
    static let shared = AppCoordinator()
    
    init() {
        router = AppRouter(navigationController: .init())
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
        showSplash()
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
        let coordinator = HomeCoordinator(router: router)
        coordinator.start()
    }
}
