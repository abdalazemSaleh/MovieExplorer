//
//  UIView+Nib.swift
//  eTrip
//
//  Created by Abdalazem Saleh on 12/11/2024.
//

import UIKit

extension UIView {
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let nibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return UIView() }
        
        return nibView
    }
}
