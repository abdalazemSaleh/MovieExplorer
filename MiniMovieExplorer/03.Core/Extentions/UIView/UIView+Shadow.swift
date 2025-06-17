import UIKit

extension UIView {
    
    @IBInspectable var ShadowHeight : Double {
        set (newValue) {
          self.shadow(newValue,self.ShadowOpacity)
        }
        get {
          return 0
        }
      }
      @IBInspectable var ShadowOpacity : Float {
        set (newValue) {
          self.shadow(self.ShadowHeight,newValue)
        }
        get {
          return 0
        }
      }
      func shadow(_ height:Double = 1.0,_ opacity:Float = 0.01){
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius)
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: height);
        layer.shadowOpacity = opacity
        layer.shadowPath = shadowPath.cgPath
        //clipsToBounds = true
      }
    
}


class ShadowView: UIView {
    /// The corner radius of the `ShadowView`, inspectable in Interface Builder
  ///
    /// The shadow color of the `ShadowView`, inspectable in Interface Builder
    @IBInspectable var shadowColor: UIColor = UIColor.black {
        didSet {
            self.updateProperties()
        }
    }
    /// The shadow offset of the `ShadowView`, inspectable in Interface Builder
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0.0, height: 2) {
        didSet {
            self.updateProperties()
        }
    }
    /// The shadow radius of the `ShadowView`, inspectable in Interface Builder
    @IBInspectable var shadowRadius: CGFloat = 4.0 {
        didSet {
            self.updateProperties()
        }
    }
    /// The shadow opacity of the `ShadowView`, inspectable in Interface Builder
  @IBInspectable var shadowWOpacity: Float = 0.5 {
        didSet {
            self.updateProperties()
        }
    }
  @IBInspectable var makeRounded: Bool = false {
      didSet {
        self.updateProperties()
      }
    }
    /**
    Masks the layer to it's bounds and updates the layer properties and shadow path.
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = false
        self.updateProperties()
        self.updateShadowPath()
    }
    /**
    Updates all layer properties according to the public properties of the `ShadowView`.
    */
    fileprivate func updateProperties() {
        self.layer.cornerRadius = self.cornerRadius
        self.layer.shadowColor = self.shadowColor.cgColor
        self.layer.shadowOffset = self.shadowOffset
        self.layer.shadowRadius = self.shadowRadius
        self.layer.shadowOpacity = self.shadowWOpacity
    if makeRounded == true {
      self.layer.cornerRadius = self.frame.height / 2
    }
    }
    /**
    Updates the bezier path of the shadow to be the same as the layer's bounds, taking the layer's corner radius into account.
    */
    fileprivate func updateShadowPath() {
        self.layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    /**
    Updates the shadow path everytime the views frame changes.
    */
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateShadowPath()
    }
}






