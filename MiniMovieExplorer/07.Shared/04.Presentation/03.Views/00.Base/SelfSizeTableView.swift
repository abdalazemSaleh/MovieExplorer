//
//  SelfSizeTableView.swift
//  eTrip
//
//  Created by Abdalazem Saleh on 01/12/2024.
//

import UIKit

final class ResizableTableView: UITableView {
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }
    
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
}
