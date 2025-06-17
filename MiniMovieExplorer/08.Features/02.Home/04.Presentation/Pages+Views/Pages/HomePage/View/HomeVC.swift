import UIKit

final class HomeVC: BaseVC {

    // MARK: - Properties
    private var viewModel: HomeViewModel
    
    // MARK: - IBOutlet
    @IBOutlet private weak var popularMoviesCollectionView: UICollectionView!
    
    // MARK: -  Init
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    override func setupView() {
        configureCollectionViews()
        Task {
            await viewModel.fetchPopularMovies()
        }
        viewModel.$movies
            .sink { [weak self] _ in
            self?.popularMoviesCollectionView.reloadData()
        }
        .store(in: &subscription)
    }
}

// MARK: - Configure Collection Views
private extension HomeVC {
    func configureCollectionViews() {
        ///  register cells
        popularMoviesCollectionView.register(cellType: MovieCollectionViewCell.self)
        
        /// setup delegate and data source
        let collectionViews = [popularMoviesCollectionView]
        collectionViews.forEach { collectionView in
            guard let collectionView else { return }
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.collectionViewLayout = MovieCollectionViewLayout()
        }
    }
}

// MARK: - Collection View Delegate And Data Source
extension HomeVC: CollectionViewProtocols {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: MovieCollectionViewCell.self, for: indexPath)
        let movieViewItem = viewModel.movies[indexPath.row]
        cell.configure(with: movieViewItem) { [weak self] isFavorite in
            self?.viewModel.favoriteButtonTapped(movieViewItem.movie, isFavorite: isFavorite)
        }
        return cell
    }
}
