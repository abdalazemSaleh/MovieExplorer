import UIKit
import Lottie

final class StateView: BaseComponent {
        
    // MARK: - IBOutlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var lottieView: LottieAnimationView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var reloadButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    let animationView = LottieAnimationView()
    
    // MARK: - Callbacks
    var onReload: (() -> Void)?
    
    // MARK: - State
    var currentState: ScreenState = .loading {
        didSet {
            updateUI()
        }
    }
        
    // MARK: - NIB
    override func nibSetup() {
        super.nibSetup()
        setupUI()
    }
    
    // MARK: - Setup
    private func setupUI() {
        animationView.frame.size = lottieView.frame.size
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit

        lottieView.addSubview(animationView)
        
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .label
        
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 0
        
        reloadButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        reloadButton.backgroundColor = .systemBlue
        reloadButton.setTitleColor(.white, for: .normal)
        reloadButton.layer.cornerRadius = 8
    }
    
    // MARK: - Private Methods
    private func updateUI() {
        switch currentState {
        case .loading:
            showLoading()
        case .empty:
            showState(.empty)
        case .error(let errorMessage):
            showState(.error(errorMessage))
        case .content:
            self.hide()
        }
    }
    
    private func showLoading() {
        containerView.hide()
        activityIndicator.startAnimating()
        show()
    }
    
    private func showState(_ state: ScreenState) {
        activityIndicator.stopAnimating()
        containerView.show()
        
        switch state {
        case .empty:
            animationView.animation = .named("empty_state")
            titleLabel.text = "No Results"
            descriptionLabel.text = "We couldn't find any movies matching your search."
            reloadButton.hide()
            
        case .error(let message):
            animationView.animation = .named("error_sate")
            titleLabel.text = "Oops!"
            descriptionLabel.text = message
            reloadButton.show()
        default:
            break
        }
        
        animationView.play()
        show()
    }
    
    // MARK: - Actions
    @IBAction private func reloadButtonTapped(_ sender: UIButton) {
        onReload?()
    }
} 
