import UIKit

class LabelLineSpacing: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setLineSpacing(lineHeightMultiple: 1.22,alignment: textAlignment)
    }
}
