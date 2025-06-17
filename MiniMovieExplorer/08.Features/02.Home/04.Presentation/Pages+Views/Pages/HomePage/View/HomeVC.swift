import UIKit

final class HomeVC: BaseVC {
    
    // MARK: - IBOutlet
    @IBOutlet weak var headerView: HomeHeaderView!
    @IBOutlet private weak var popularMoviesCollectionView: UICollectionView!
    
    // MARK: - Properties
    private var viewModel: HomeViewModel
    private var lastContentOffset: CGFloat = 0
    private let searchFieldMaxHeight: CGFloat = 56
    private let searchFieldMinHeight: CGFloat = 0

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
  
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.loadMoreIfNeeded(currentItem: indexPath.item)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        /// Pagination
//        let visibleRect = CGRect(origin: scrollView.contentOffset, size: scrollView.bounds.size)
//        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
//
//        if let visibleIndexPath = popularMoviesCollectionView.indexPathForItem(at: visiblePoint) {
//            print("Visible index: \(visibleIndexPath.item)")
//            viewModel.loadMoreIfNeeded(currentItem: visibleIndexPath.item)
//        } else {
//            print("No visible index path for point: \(visiblePoint)")
//        }

        /// Header animation
        let currentOffset = scrollView.contentOffset.y
        
        if currentOffset <= 0 {
            UIView.animate(withDuration: 0.2) {
                self.headerView.searchTextFieldHeight.constant = self.searchFieldMaxHeight
                self.view.layoutIfNeeded()
            }
            lastContentOffset = 0
            return
        }
        
        let differenceFromStart = currentOffset - lastContentOffset
        let isScrollingDown = differenceFromStart > 0
        let isScrollingUp = differenceFromStart < 0
        
        let currentHeight = headerView.searchTextFieldHeight.constant
        
        var newHeight: CGFloat
        if isScrollingDown {
            newHeight = max(searchFieldMinHeight, currentHeight - abs(differenceFromStart))
        } else if isScrollingUp {
            newHeight = min(searchFieldMaxHeight, currentHeight + abs(differenceFromStart))
        } else {
            return
        }
        
        UIView.animate(withDuration: 0.2) {
            self.headerView.searchTextFieldHeight.constant = newHeight
            self.view.layoutIfNeeded()
        }
        
        lastContentOffset = currentOffset
    }
}
