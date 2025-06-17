import UIKit

public class BaseComponent: UIView {
    
    // MARK: Propertys
    /// Public propertys
    var hasButtonEffect: Bool = false {
        didSet {
            guard hasButtonEffect else { return }
            setupButtonEffect()
        }
    }
    
    var disableClick: Bool = false {
        didSet {
            hasButtonEffect = !disableClick
            isEnabled = !disableClick
        }
    }
    var actionWhenTap: (() -> ())?
    /// Private propertys for button effect
    private let ANIMATION_DURATION = 0.1
    private var isEnabled: Bool = true
    private var isEffectEnabled: Bool = true
    
    // MARK: - Initilizer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
}

// MARK: - Setup as nib

extension BaseComponent {
    @objc func nibSetup() {
        backgroundColor = .clear
        let containerView = loadViewFromNib()
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.translatesAutoresizingMaskIntoConstraints = true
        addSubview(containerView)
    }
}

// MARK: - Setup button effect

private extension BaseComponent {
    func setupButtonEffect() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTouch(_:))))
        isUserInteractionEnabled = true
    }
    
    @objc
    func didTouch(_ sender: UITapGestureRecognizer) {
        guard isEnabled else { return }
        actionWhenTap?()
        beginAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + ANIMATION_DURATION) {
            self.endAnimation()
        }
    }
}

// MARK: - Animations

private extension BaseComponent {
    func beginAnimation() {
        guard isEnabled else { return }
        guard isEffectEnabled else { return }
        UIView.animate(withDuration: ANIMATION_DURATION) {
            self.alpha = 0.7
            self.subviews.forEach({ $0.alpha = 0.2 })
        }
    }
    
    func endAnimation() {
        UIView.animate(withDuration: ANIMATION_DURATION) {
            self.alpha = 1
            self.subviews.forEach({ $0.alpha = 1 })
        }
    }
}

// MARK: - Touches states

extension BaseComponent {
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard hasButtonEffect else { return }
        beginAnimation()
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard hasButtonEffect else { return }
        endAnimation()
    }
        
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        guard hasButtonEffect else { return }
        endAnimation()
    }
}
