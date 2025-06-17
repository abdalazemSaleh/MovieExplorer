import UIKit

class PopupVC: UIViewController {
    
    // MARK: - Properties
    let backgroundView = UIView()
    private var containerView: UIView?
    
    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
        DebugTracker.track(object: self)
        print("Tracked: \(self)")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Deinit
    deinit {
        DebugTracker.untrack(object: self)
        print("Untracked: \(self)")
    }
}

// MARK: - View Lifecycle
extension PopupVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.backgroundView.alpha = 1
        containerView?.popIn()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.backgroundView.alpha = 0
    }
}

// MARK: - Setup UI
extension PopupVC {
    @objc func setupView() {
        setupBackgroundView()
        setupTapGestureRecognizer()
        setupPanGestureRecognizer()
    }
    
    private func setupBackgroundView() {
        view.insertSubview(backgroundView, at: 0)
        backgroundView.fillSuperview()
        backgroundView.backgroundColor = .black.withAlphaComponent(0.4)
        backgroundView.alpha = 0
    }
    
    private func setupTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewBackTap))
        backgroundView.addGestureRecognizer(tap)
    }
    
    private func setupPanGestureRecognizer() {
        guard let container = view.subviews[safe: 1] else { return }
        containerView = container
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        container.addGestureRecognizer(panGesture)
    }
    
    @objc private func viewBackTap() {
        dismissPopup()
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let container = containerView else { return }
        
        let translation = gesture.translation(in: view)
        let progress = min(1, max(0, translation.y / container.frame.height))
        
        switch gesture.state {
        case .changed:
            if translation.y > 0 {
                container.transform = CGAffineTransform(translationX: 0, y: translation.y)
                backgroundView.alpha = max(0, (1 - progress))
            }
        case .ended:
            if progress > 0.4 {
                dismissPopup()
            } else {
                UIView.animate(withDuration: 0.4) {
                    container.transform = .identity
                    self.backgroundView.alpha =  1
                }
            }
        default:
            break
        }
    }
    
    func dismissPopup() {
        dimsisMe {
            self.dismiss(animated: false)
        }
    }
}

// MARK: - Dismiss Function
extension PopupVC {
    func dimsisMe(completion: @escaping () -> Void) {
        if let container = containerView {
            container.popOut(toScale: 0.2) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
}
