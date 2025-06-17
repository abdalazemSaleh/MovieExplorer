import UIKit

final class FavoriteButton: UIView {

    // MARK: - Public Properties
    var isFavorited: Bool = false {
        didSet {
            updateAppearance(animated: true)
        }
    }

    var onToggle: ((Bool) -> Void)?

    // MARK: - Private Properties
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        return button
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Setup
    private func setupUI() {
        addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        styleButton()
    }

    private func styleButton() {
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
    }

    // MARK: - Toggle
    @objc private func toggleFavorite() {
        isFavorited.toggle()
        onToggle?(isFavorited)
    }

    private func updateAppearance(animated: Bool) {
        let imageName = isFavorited ? "heart.fill" : "heart"
        let color: UIColor = isFavorited ? .systemRed : .white
        let bgColor: UIColor = isFavorited ? .white : UIColor.black.withAlphaComponent(0.4)

        let changes = {
            self.button.setImage(UIImage(systemName: imageName), for: .normal)
            self.button.tintColor = color
            self.button.backgroundColor = bgColor
        }

        if animated {
            UIView.transition(with: button, duration: 0.2, options: .transitionCrossDissolve, animations: changes)
            self.button.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            UIView.animate(withDuration: 0.25, delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 3,
                           options: .curveEaseInOut,
                           animations: {
                               self.button.transform = .identity
                           })
        } else {
            changes()
        }
    }
}
