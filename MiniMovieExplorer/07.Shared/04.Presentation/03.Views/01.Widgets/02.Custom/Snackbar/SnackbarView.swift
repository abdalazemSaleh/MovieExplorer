import UIKit
import Foundation

final class SnackbarView: UIView {
    private let label = UILabel()
    private var hideWorkItem: DispatchWorkItem?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        backgroundColor = UIColor.label.withAlphaComponent(0.5)
        layer.cornerRadius = 8
        clipsToBounds = true
        alpha = 0

        label.textColor = .appBackground
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false

        addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }

    private func show(in parent: UIView, message: String, duration: TimeInterval = 3.0) {
        label.text = message

        if superview == nil {
            parent.addSubview(self)
            translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 24),
                trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -24),
                bottomAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.bottomAnchor, constant: -24)
            ])
        }

        parent.bringSubviewToFront(self)
        UIView.animate(withDuration: 0.3) { self.alpha = 1 }

        hideWorkItem?.cancel()
        let workItem = DispatchWorkItem { [weak self] in
            self?.hideSnackBar()
        }
        hideWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: workItem)
    }

    private func hideSnackBar() {
        UIView.animate(withDuration: 0.3) { self.alpha = 0 }
    }

    // MARK: - Static API
    @discardableResult
    static func show(message: String, in parent: UIView, duration: TimeInterval = 3.0) -> SnackbarView {
        // Remove any existing SnackbarView
        if let existing = parent.subviews.first(where: { $0 is SnackbarView }) as? SnackbarView {
            existing.hideSnackBar()
            existing.removeFromSuperview()
        }
        let snackbar = SnackbarView()
        snackbar.show(in: parent, message: message, duration: duration)
        return snackbar
    }
} 
