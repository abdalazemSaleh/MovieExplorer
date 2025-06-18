import UIKit

class ButtonView: BaseComponent {

    // MARK: - IBOUTLET
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var leadingImageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var tralingImageView: UIImageView!

    // MARK: - PROPERTIES
    var state: ButtonConfigurations.State = .normal(.black) {
        didSet {
            switch state {
            case .normal(let color):
                disableClick = false
                handleButtonBackground(with: color)
            case .disabled(let color):
                disableClick = true
                handleButtonBackground(with: color.withAlphaComponent(0.2))
            case .delete:
                disableClick = false
                handleButtonBackground(with: .appColor(.red))
            }
        }
    }

    var style: ButtonConfigurations.Style = .defult {
        didSet {
            switch style {
            case .defult:
                break
            case .bordered:
                hasButtonEffect = true
                handleButtonBackground(with: .clear)
            case .withImage(let alignment, let image):
                handleButtonStyle(with: image, alignment: alignment)
            }
        }
    }

    // MARK: - Customizable IBInspectable
    @IBInspectable var localizationFile: String = "MainApp" {
        didSet { updateText() }
    }

    @IBInspectable var buttonText: String = "" {
        didSet { updateText() }
    }

    @IBInspectable var leadingImage: UIImage = .checkmark {
        didSet {
            leadingImageView.image = leadingImage
            leadingImageView.isHidden = false
        }
    }

    @IBInspectable var textSize: CGFloat = 16 {
        didSet {
            textLabel.font = UIFont.main(weight: .bold, ofSize: textSize)
        }
    }

    @IBInspectable var textColor: UIColor = .appColor(.primary) {
        didSet {
            textLabel.textColor = textColor
        }
    }

    @IBInspectable var mainColor: UIColor = .appColor(.primary) {
        didSet {
            containerView.backgroundColor = mainColor
        }
    }

    @IBInspectable var useDashedBorder: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable var customBorderColor: UIColor = .red {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable var dashWidth: CGFloat = 1
    @IBInspectable var dashLength: CGFloat = 6
    @IBInspectable var betweenDashesSpace: CGFloat = 3

    // MARK: - NIB
    override func nibSetup() {
        super.nibSetup()
        containerView.layer.cornerRadius = 16
        containerView.layer.masksToBounds = true
        hasButtonEffect = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        applyBorderStyle()
    }

    // MARK: - Update Text
    private func updateText() {
        textLabel.text = buttonText.localized(from: .init(rawValue: localizationFile))
        textLabel.show()
    }

    // MARK: - Border Styling
    private func applyBorderStyle() {
        // Clear old border
        containerView.layer.borderColor = nil
        containerView.layer.borderWidth = 0
        containerView.layer.sublayers?.removeAll(where: { $0.name == "DashedBorder" })

        if useDashedBorder {
            let dashBorder = CAShapeLayer()
            dashBorder.name = "DashedBorder"
            dashBorder.strokeColor = customBorderColor.cgColor
            dashBorder.lineWidth = dashWidth
            dashBorder.lineDashPattern = [dashLength, betweenDashesSpace] as [NSNumber]
            dashBorder.fillColor = UIColor.clear.cgColor
            dashBorder.frame = containerView.bounds
            dashBorder.path = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: containerView.layer.cornerRadius).cgPath
            containerView.layer.addSublayer(dashBorder)
        } else {
            containerView.layer.borderColor = customBorderColor.cgColor
            containerView.layer.borderWidth = 1
        }
    }
}

// MARK: - LOGIC
private extension ButtonView {
    func handleButtonStyle(with image: UIImage, alignment: ButtonConfigurations.Style.ImageAlignment) {
        leadingImageView.isHidden = alignment == .right
        tralingImageView.isHidden = alignment == .left

        leadingImageView.image = image
        tralingImageView.image = image
    }

    func handleButtonBackground(with color: UIColor) {
        containerView.backgroundColor = color
        textLabel.textColor = color == .white ? .appColor(.primary) : .white
    }
}

