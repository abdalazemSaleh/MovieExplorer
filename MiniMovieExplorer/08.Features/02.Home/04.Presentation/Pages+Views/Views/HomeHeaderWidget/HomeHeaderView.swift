import UIKit

class HomeHeaderView: BaseComponent {

    // MARK: - IBOUTLET
    @IBOutlet weak var searchTextField: UISearchBar!
    @IBOutlet weak var searchTextFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Proeprties
    var favoriteButtonAction: () -> Void = { }
    
    // MARK: - NIB
    override func nibSetup() {
        super.nibSetup()
    }

    // MARK: - IBActions
    @IBAction func favoriteButton(_ sender: UIButton) {
        favoriteButtonAction()
    }
}

