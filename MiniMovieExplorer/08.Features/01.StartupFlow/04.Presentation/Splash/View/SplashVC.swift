import UIKit

final class SplashVC: BaseVC {
    
    @IBOutlet weak var animationView: UIView!
    
    // MARK: - Setup View
    override func setupView() {
        setupLogtiteView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            AppCoordinator.shared.showHome()
        }
    }
}

// MARK: - Functions
private extension SplashVC {
    func setupLogtiteView() {
        animationView.configureLottieView(animation: "")
    }
    
    #warning("return animation file base on currnet them")
    func getLottieJsonFileName() -> String {
        return ""
    }
}
