//
//  CustomTableView.swift
//  AseerAlkotb
//
//  Created by Abdalazem Saleh on 10/02/2025.
//

import UIKit

class CustomTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupDefaults()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDefaults()
    }
    
    private func setupDefaults() {
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        separatorStyle = .none
    }
}
