import UIKit

final class HomeVC: BaseVC {
    
    // MARK: - IBOutlet
    @IBOutlet weak var headerView: HomeHeaderView!
    @IBOutlet private weak var popularMoviesCollectionView: UICollectionView!
    @IBOutlet weak var stateView: StateView!

    // MARK: - Properties
    private var viewModel: HomeViewModel
    private var lastContentOffset: CGFloat = 0

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
        setupHomeHeaderView()
        configureCollectionViews()
        setupBindings()
    }
    private func setupHomeHeaderView() {
        headerView.favoriteButtonAction = { [weak self] in self?.viewModel.showFavoritesPage() }
    }
    
    private func setupBindings() {
        headerView.searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] text in
                self?.viewModel.searchText = text
            }
            .store(in: &subscription)
        
        viewModel.$filteredMovies
            .sink { [weak self] _ in
                self?.popularMoviesCollectionView.reloadData()
            }
            .store(in: &subscription)
        
        viewModel.$screenState
            .sink { [weak self] state in
                guard let self else { return }
                guard !viewModel.isLoadingOtherPages else { return }
                stateView.currentState = state
                switch state {
                case .content:
                    stateView.hide()
                    popularMoviesCollectionView.show()
                default:
                    popularMoviesCollectionView.hide()
                    stateView.show()
                }
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
        return viewModel.filteredMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: MovieCollectionViewCell.self, for: indexPath)
        let movieViewItem = viewModel.filteredMovies[indexPath.row]
        cell.configure(with: movieViewItem) { [weak self] isFavorite in
            self?.viewModel.favoriteButtonTapped(movieViewItem.movie, isFavorite: isFavorite)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.filteredMovies[indexPath.row]
        viewModel.showDetails(movieID: movie.movie.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.loadMoreIfNeeded(currentItem: indexPath.item)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        
        if currentOffset <= 0 {
            UIView.animate(withDuration: 0.2) {
                self.headerView.searchTextFieldHeight.constant = HomeHeaderView.Constant.SEARCH_FIELD_MAX_HEIGHT
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
            newHeight = max(HomeHeaderView.Constant.SEARCH_FIELD_MIN_HEIGHT, currentHeight - abs(differenceFromStart))
        } else if isScrollingUp {
            newHeight = min(HomeHeaderView.Constant.SEARCH_FIELD_MAX_HEIGHT, currentHeight + abs(differenceFromStart))
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
