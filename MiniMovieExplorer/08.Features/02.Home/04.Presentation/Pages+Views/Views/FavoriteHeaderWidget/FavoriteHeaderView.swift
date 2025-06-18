import UIKit
import Combine

class FavoriteHeaderView: BaseComponent {

    // MARK: - IBOUTLET
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchTextField: UISearchBar!
    @IBOutlet weak var searchTextFieldHeight: NSLayoutConstraint!
    
    // MARK: - Proeprties
    var backButtonAction: () -> Void = { }
    let searchText = EventPublisher<String>()
    
    struct Constant {
        static let SEARCH_FIELD_MAX_HEIGHT: CGFloat = 56
        static let SEARCH_FIELD_MIN_HEIGHT: CGFloat = 0
    }
    
    // MARK: - NIB
    override func nibSetup() {
        super.nibSetup()
        setupSearchTextField()
    }

    // MARK: - IBActions
    @IBAction func backButton(_ sender: UIButton) {
        backButtonAction()
    }
    
    // MARK: - Setup
    private func setupSearchTextField() {
        searchTextField.delegate = self
    }
}

// MARK: - UISearchBarDelegate
extension FavoriteHeaderView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText.send(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.searchText.send("")
        searchBar.resignFirstResponder()
    }
}


