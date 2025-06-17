//
//  CustomNavBar.swift
//  AseerAlkotb
//
//  Created by Abdalazem Saleh on 05/02/2025.
//

import UIKit

class CustomNavBar: BaseComponent {
    
    // MARK: - Outlets
    @IBOutlet weak var mainStack: UIStackView!
    @IBOutlet weak var leadingConstraints: NSLayoutConstraint!
    @IBOutlet weak var tralingConstraints: NSLayoutConstraint!
    @IBOutlet weak var backButtonView: ClickableImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Properties
    @IBInspectable var hasPadding: Bool = false {
        didSet {
            guard hasPadding else { return }
            updatePadding()
        }
    }
    
    @IBInspectable var localizationFile: String = "MainApp" {
        didSet {
            updateText()
        }
    }
    
    @IBInspectable var title: String = "" {
        didSet {
            updateText()
        }
    }

    // MARK: - Init
    override func nibSetup() {
        super.nibSetup()
        setupView()
    }
    
    // MARK: - Helper Functions
    private func setupView() {
        backButtonView.actionWhenTapped = {
            AppCoordinator.shared.pop()
        }
    }
    
    private func updatePadding() {
        leadingConstraints.constant = 20
        tralingConstraints.constant = 20
    }
    
    private func updateText() {
        titleLabel.text = title.localized(from: .init(rawValue: localizationFile))
        titleLabel.show()
    }

}
