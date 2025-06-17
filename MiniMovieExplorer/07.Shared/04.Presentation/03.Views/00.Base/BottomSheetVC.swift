import UIKit

class BottomSheetVC: UIViewController {
    
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
extension BottomSheetVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(
            withDuration: 0.4,
            delay: 0.4,
            options: .curveEaseInOut,
            animations: {
                self.backgroundView.alpha = 1
            },
            completion: nil)
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(
            withDuration: 0.4,
            delay: 0.4,
            options: .curveEaseInOut,
            animations: {
                self.backgroundView.alpha = 0
            },
            completion: nil)
    }
}

// MARK: - Setup UI
extension BottomSheetVC {
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
extension BottomSheetVC {
    func dimsisMe(completion: @escaping () -> Void) {
        if let container = containerView {
            container.slideOut(to: .bottom, y: container.frame.height, duration: 0.8)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                completion()
            }
        } else {
            completion()
        }
    }
}
