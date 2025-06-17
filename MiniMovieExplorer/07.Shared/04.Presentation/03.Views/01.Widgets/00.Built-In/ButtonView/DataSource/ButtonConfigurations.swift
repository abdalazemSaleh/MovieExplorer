import UIKit

class ButtonConfigurations {
    enum State {
        case normal(UIColor = .appColor(.primary))
        case disabled(UIColor = .appColor(.primary))
        case delete
    }
    
    enum Style {
        case defult
        case bordered
        case withImage(ImageAlignment, UIImage)
        
        enum ImageAlignment {
            case left
            case right
        }
    }
}

