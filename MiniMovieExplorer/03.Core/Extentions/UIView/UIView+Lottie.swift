import UIKit
import Lottie

extension UIView {
    func configureLottieView(animation: String) {
        /// configure view
        let lottieView = LottieAnimationView(name: animation)
        lottieView.frame = self.bounds
        lottieView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(lottieView)
        /// customize view
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .loop
        lottieView.animationSpeed = 1
        lottieView.play()
    }
}
