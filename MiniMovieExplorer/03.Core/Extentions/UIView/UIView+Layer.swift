//
//  View+Layer.swift
//  eTrip
//
//  Created by Abdalazem Saleh on 19/11/2024.
//

import UIKit

extension UIView {

    // MARK: - Corner Radius
    @IBInspectable
    var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }

    // MARK: - Border Width
    @IBInspectable
    var borderWidth: CGFloat {
        get { return self.layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }

    // MARK: - Border Color
    @IBInspectable
    var borderColor: UIColor? {
        get {
            guard let cgColor = self.layer.borderColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set {
            if borderWidth == 0 {
                borderWidth = 1 // Default border width
            }
            self.layer.borderColor = newValue?.cgColor
        }
    }

    // MARK: - Rotation (in Degrees)
    @IBInspectable
    var rotationAngle: CGFloat {
        get {
            let radians = atan2(self.transform.b, self.transform.a)
            return radians * 180 / .pi
        }
        set {
            let radians = newValue * .pi / 180
            self.transform = CGAffineTransform(rotationAngle: radians)
        }
    }

    // MARK: - Make View Rounded
    func makeRounded() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
    }

}
