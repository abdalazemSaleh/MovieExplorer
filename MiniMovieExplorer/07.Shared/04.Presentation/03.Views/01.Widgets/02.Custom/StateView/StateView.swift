import UIKit
import Lottie

final class StateView: BaseComponent {
    
    // MARK: - Properties
    enum State {
        case empty
        case error
    }
    
    // MARK: - IBOutlets
    @IBOutlet private weak var containerView: UIView!
//    @IBOutlet private weak var animationView: LottieAnimationView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var reloadButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Callbacks
    var onReload: (() -> Void)?
    
    // MARK: - State
    private var currentState: State?
    private var isLoading: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - NIB
    override func nibSetup() {
        super.nibSetup()
        setupUI()
    }
    
    // MARK: - Setup
    private func setupUI() {
//        animationView.contentMode = .scaleAspectFit
//        animationView.loopMode = .loop
        
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
    
    // MARK: - Public Methods
    func configure(state: State?, isLoading: Bool) {
        self.currentState = state
        self.isLoading = isLoading
    }
    
    // MARK: - Private Methods
    private func updateUI() {
        if isLoading {
            print("Loading........")
            showLoading()
        } else if let state = currentState {
            showState(state)
        } else {
            hide()
        }
    }
    
    private func showLoading() {
        containerView.hide()
        activityIndicator.startAnimating()
        show()
    }
    
    private func showState(_ state: State) {
        activityIndicator.stopAnimating()
        containerView.show()
        
        switch state {
        case .empty:
//            animationView.animation = .named("empty_state")
            titleLabel.text = "No Results"
            descriptionLabel.text = "We couldn't find any movies matching your search."
            reloadButton.isHidden = true
            
        case .error:
//            animationView.animation = .named("error_state")
            titleLabel.text = "Oops!"
            descriptionLabel.text = "Something went wrong. Please try again."
            reloadButton.isHidden = false
        }
        
//        animationView.play()
        show()
    }
    
    // MARK: - Actions
    @IBAction private func reloadButtonTapped(_ sender: UIButton) {
        onReload?()
    }
} 
