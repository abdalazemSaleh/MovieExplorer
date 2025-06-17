import UIKit
import Lottie

class CustomLottieView: LottieAnimationView {
    
    @IBInspectable var isActionEnabled: Bool = false {
        didSet {
            isUserInteractionEnabled = isActionEnabled
            if isActionEnabled {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
                self.addGestureRecognizer(tapGesture)
            }
        }
    }
    
    var actionWhenTapped: (() -> Void)?
    
    @objc private func handleTap() {
        actionWhenTapped?()
    }
    
    @IBInspectable var animationFile: String? {
        didSet {
            if let name = animationFile {
                self.animation = .named(name)
                self.play()
            }
        }
    }
    
    @IBInspectable var loop: Bool = true {
        didSet {
            self.loopMode = loop ? .loop : .playOnce
        }
    }
    
    
    @IBInspectable var scale: UIView.ContentMode = .scaleAspectFit {
        didSet {
            self.contentMode = scale
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.loopMode = .loop
        self.contentMode = .scaleAspectFit
        self.backgroundColor = .clear
    }
    
    func startAnimation() {
        self.play()
    }
}
