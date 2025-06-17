import UIKit

extension UILabel {
    
    @IBInspectable var FontBoldSize: CGFloat {
        get {
            return self.font.pointSize
        }
        set {
            if newValue > 0 {
                self.font = .main(weight: .bold, ofSize: newValue)
            }
           
        }
    }
    
    @IBInspectable var FontSemiBoldSize: CGFloat {
        get {
            return self.font.pointSize
        }
        set {
            if newValue > 0 {
                self.font = .main(weight: .semiBold, ofSize: newValue)
            }
           
        }
    }

    @IBInspectable var FontMediumSize: CGFloat {
        get {
            return self.font.pointSize
        }
        set {
            if newValue > 0 {
                self.font = .main(weight: .medium, ofSize: newValue)
            }
           
        }
    }
    
    @IBInspectable var FontRegularSize: CGFloat {
        get {
            return self.font.pointSize
        }
        set {
            if newValue > 0 {
                self.font = .main(weight: .regular, ofSize: newValue)
            }
           
        }
    }
}



extension UITextField {
    
    
    @IBInspectable var FontSemiBoldSize: CGFloat {
        get {
            return self.font?.pointSize ?? 0
        }
        set {
            if newValue > 0 {
                self.font = .main(weight: .semiBold, ofSize: newValue)
            }
           
        }
    }

    @IBInspectable var FontMediumSize: CGFloat {
        get {
            return self.font?.pointSize ?? 0
        }
        set {
            if newValue > 0 {
                self.font = .main(weight: .medium, ofSize: newValue)
            }
           
        }
    }
    
    @IBInspectable var FontRegularSize: CGFloat {
        get {
            return self.font?.pointSize ?? 0
        }
        set {
            if newValue > 0 {
                self.font = .main(weight: .regular, ofSize: newValue)
            }
           
        }
    }
}

extension UIButton {
    
    var font: UIFont {
            get {
                return titleLabel!.font
            }
            set {
                titleLabel!.font = newValue
            }
        }
    
    @IBInspectable var FontBoldSize: CGFloat {
        get {
            return self.font.pointSize
        }
        set {
            if newValue > 0 {
                self.font = .main(weight: .bold, ofSize: newValue)
            }
           
        }
    }
    
    @IBInspectable var FontSemiBoldSize: CGFloat {
        get {
            return self.font.pointSize
        }
        set {
            if newValue > 0 {
                self.font = .main(weight: .semiBold, ofSize: newValue)
            }
           
        }
    }

    @IBInspectable var FontMediumSize: CGFloat {
        get {
            return self.font.pointSize
        }
        set {
            if newValue > 0 {
                self.font = .main(weight: .medium, ofSize: newValue)
            }
           
        }
    }
    
    @IBInspectable var FontRegularSize: CGFloat {
        get {
            return self.font.pointSize
        }
        set {
            if newValue > 0 {
                self.font = .main(weight: .regular, ofSize: newValue)
            }
           
        }
    }
}
