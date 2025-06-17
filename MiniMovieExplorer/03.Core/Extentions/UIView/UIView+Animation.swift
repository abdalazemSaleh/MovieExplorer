//
//  View+Animation.swift
//  eTrip
//
//  Created by Abdalazem Saleh on 17/11/2024.
//

import UIKit

extension UIView {
    func fadeInBackground(duration: TimeInterval = 0.3,
                after: TimeInterval = 0.25,
                alpha: CGFloat = 0.5,
                color backgroudColor: UIColor = .black) {
        self.backgroundColor = backgroudColor.withAlphaComponent(0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            UIView.animate(withDuration: duration, animations: {
                self.backgroundColor = backgroudColor.withAlphaComponent(alpha)
            })
        }
    }
    
    func fadeOutBackground(duration: TimeInterval? = 0.2,
                   after: TimeInterval = 0,
                   alpha: CGFloat = 0.5,
                   color backgroudColor: UIColor = .black) {
        if let duration = duration {
            self.backgroundColor = backgroudColor.withAlphaComponent(alpha)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + after) {
                UIView.animate(withDuration: duration, animations: {
                    self.backgroundColor = backgroudColor.withAlphaComponent(0)
                })
            }
        } else {
            self.backgroundColor = self.backgroundColor?.withAlphaComponent(0)
        }
    }
}
