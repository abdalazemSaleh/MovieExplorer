import UIKit

final class SplashVC: BaseVC {
    
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var appNameLabel: UILabel!
    
    // MARK: - Setup View
    override func setupView() {
        setupLogtiteView()
        setupAppNameLabel()
        showHome()
    }
}

// MARK: - Functions
private extension SplashVC {
    func setupLogtiteView() {
        animationView.configureLottieView(animation: getLottieJsonFileName())
    }
    
    func setupAppNameLabel() {
        appNameLabel.font = UIFont.bebasNeue(ofSize: 24)
        appNameLabel.popIn(duration: 1.5)
    }
    
    func showHome() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
            AppCoordinator.shared.showHome()
        }
    }
    
    #warning("return animation file base on currnet them")
    func getLottieJsonFileName() -> String {
        return "splash_loader"
//        return Theme.isDarkMode() ?  : ""
    }
}
