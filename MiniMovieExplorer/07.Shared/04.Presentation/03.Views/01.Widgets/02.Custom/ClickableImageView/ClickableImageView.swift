//
//  ClickableImageView.swift
//  eTrip
//
//  Created by Abdalazem Saleh on 17/11/2024.
//


import UIKit

class ClickableImageView: UIImageView {

    // MARK: - Propertys
    /// Public propertys
    var actionWhenTapped: (() -> ())?
    /// Private propertys for button effect
    private let ANIMATION_DURATION = 0.1
    private var isEnabled: Bool = true
    private var isEffectEnabled: Bool = true
    
    // MARK: - Setup
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtonEffect()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButtonEffect()
    }
}

// MARK: - Setup button effect
private extension ClickableImageView {
    func setupButtonEffect() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTouch(_:))))
        isUserInteractionEnabled = true
    }
    
    @objc
    func didTouch(_ sender: UITapGestureRecognizer) {
        guard isEnabled else { return }
        actionWhenTapped?()
        beginAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + ANIMATION_DURATION) {
            self.endAnimation()
        }
    }
}

// MARK: - Animations
private extension ClickableImageView {
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
extension ClickableImageView {
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        beginAnimation()
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        endAnimation()
    }
        
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        endAnimation()
    }
}
