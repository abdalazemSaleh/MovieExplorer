import UIKit

class MovieDetailsHeader: BaseComponent {

    // MARK: - IBOUTLET
    @IBOutlet weak var backButton: BlurButton!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var genresCollectionView: UICollectionView!
    
    // MARK: - Proeprties
    var genres: [Genre] = [] {
        didSet {
            genresCollectionView.reloadData()
        }
    }
    
    var backButtonAction: () -> Void = { } {
        didSet {
            backButton.onTap = backButtonAction
        }
    }
    
    // MARK: - NIB
    override func nibSetup() {
        super.nibSetup()
        configureCollectionViews()
    }

    // MARK: - IBActions
    @IBAction func imdbLink(_ sender: UIButton) {
    }
    
    // MARK: - Setup
}

// MARK: - ConfigureCollectionView
extension MovieDetailsHeader {
    func configureCollectionViews() {
        ///  register cells
        genresCollectionView.register(cellType: GenreCollectionViewCell.self)
        
        /// setup delegate and data source
        let collectionViews = [genresCollectionView]
        collectionViews.forEach { collectionView in
            guard let collectionView else { return }
            collectionView.dataSource = self
            collectionView.delegate = self
//            collectionView.collectionViewLayout = MovieCollectionViewLayout()
        }
    }
}

// MARK: - Collection View Delegate And Data Source
extension MovieDetailsHeader: CollectionViewProtocols {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: GenreCollectionViewCell.self, for: indexPath)
        let genre = genres[indexPath.row]
        cell.configure(with: genre.name)
        return cell
    }
}

