import UIKit
import Combine

class HomeHeaderView: BaseComponent {

    // MARK: - IBOUTLET
    @IBOutlet weak var searchTextField: UISearchBar!
    @IBOutlet weak var searchTextFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Proeprties
    var favoriteButtonAction: () -> Void = { }
    let searchText = EventPublisher<String>()
    
    // MARK: - NIB
    override func nibSetup() {
        super.nibSetup()
        setupSearchTextField()
    }

    // MARK: - IBActions
    @IBAction func favoriteButton(_ sender: UIButton) {
        favoriteButtonAction()
    }
    
    // MARK: - Setup
    private func setupSearchTextField() {
        searchTextField.delegate = self
    }
}

// MARK: - UISearchBarDelegate
extension HomeHeaderView: UISearchBarDelegate {
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


