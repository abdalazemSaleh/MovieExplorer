import UIKit

class MovieDetailsHeader: BaseComponent {

    // MARK: - IBOUTLET
    @IBOutlet weak var backButton: BlurButton!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var genresCollectionView: UICollectionView!
    
    // MARK: - Proeprties

    // MARK: - NIB
    override func nibSetup() {
        super.nibSetup()
    }

    // MARK: - IBActions
    @IBAction func imdbLink(_ sender: UIButton) {
    }
    
    // MARK: - Setup
}
