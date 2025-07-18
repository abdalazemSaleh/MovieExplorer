import UIKit

protocol Coordinator: AnyObject {
    var router: Router { get }
    var currentViewController: UIViewController { get }
    
    func start()
}

extension Coordinator {
    var currentViewController: UIViewController {
        return router.navigationController.visibleViewController!
    }
    
    func dismiss(completion: @escaping () -> Void = {} ) {
        router.dismiss(animated: true, completion: completion)
    }
    
    func dismissPopup(completion: @escaping () -> Void = { }) {
        router.dismissPopup { [weak self] in
            self?.router.dismiss(animated: false, completion: completion)
        }
    }
    
    func popToRoot(completion: @escaping () -> Void = { }) {
        router.popToRoot(animated: false, completion: completion)
    }
    
    func pop() {
        router.pop(animated: true, completion: {})
    }
    
    func showAlert(alert: UIAlertController) {
        router.present(alert)
    }
    
    func showSnakeBar(message: String) {
        if let view = currentViewController.view {
            SnackbarView.show(message: message, in: view)
        } else {
            print("Error while show bar")
        }
    }
}
