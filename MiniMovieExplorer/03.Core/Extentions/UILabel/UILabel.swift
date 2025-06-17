import UIKit

extension UILabel {
    func setLineSpacing(lineSpacing: CGFloat = 1, lineHeightMultiple: CGFloat = 1.22,alignment:NSTextAlignment = .natural) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakMode = .byTruncatingTail
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
    
    var trimmedText : String? {
        set (newValue) {
            self.text = newValue?.trim()
        }
        get {
            return self.text
        }
    }
    
    @IBInspectable var capitalized : Bool {
        set (newValue) {
            if(newValue){
                self.text = self.text?.capitalized
            }else{
                self.text = self.text
            }
        }
        get {
            return false
        }
    }
}
