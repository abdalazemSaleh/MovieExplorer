import UIKit
import Combine

class BaseVC: UIViewController {
    // MARK: - Propertys
    var subscription = Set<AnyCancellable>()

    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        DebugTracker.track(object: self)
        print("Tracked: \(self)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Deinit
    deinit {
        subscription.removeAll()
        DebugTracker.untrack(object: self)
        print("Untracked: \(self)")
    }
}

// MARK: - View life cycle
extension BaseVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addEvent()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - Base Functions
extension BaseVC {
    @objc func setupView() {
        
    }
    
    @objc func addEvent() {
        
    }
    
    @objc func bindViewModel() {
        
    }
}
