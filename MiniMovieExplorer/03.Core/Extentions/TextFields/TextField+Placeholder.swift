import UIKit

private var __maxLengths = [UITextField: Int]()

extension UITextField {
    func setPlaceholderFont(_ font: UIFont, color: UIColor = .gray) {
        guard let placeholderText = self.placeholder else { return }
        self.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [
                .font: font,
                .foregroundColor: color
            ]
        )
    }
    
    func setTextFieldTextFont(_ font: UIFont, color: UIColor = .black) {
        self.font = font
        self.textColor = color
    }
    
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    
    @objc func fix(textField: UITextField) {
        if let t = textField.text {
            textField.text = String(t.prefix(maxLength))
        }
    }
    
    func clear()
    {
        self.text = ""
    }
}
