import UIKit

class FavoriteVC: BaseVC {
    // MARK: - IBOutlet
    @IBOutlet private weak var favoritesCollectionView: UICollectionView!
    @IBOutlet weak var headerView: FavoriteHeaderView!
    
    // MARK: - Properties
    private var viewModel: FavoriteViewModel
    private var lastContentOffset: CGFloat = 0

    //    MARK: -  Init
    init(viewModel: FavoriteViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    override func setupView() {
        setupFavoriteHeaderView()
        configureCollectionViews()
        setupBindings()
    }
    
    private func setupFavoriteHeaderView() {
        headerView.backButtonAction = { [weak self] in self?.viewModel.backButtonTapped() }
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
                self?.favoritesCollectionView.reloadData()
            }
            .store(in: &subscription)
    }
}

// MARK: - Configure Collection Views
private extension FavoriteVC {
    func configureCollectionViews() {
        ///  register cells
        favoritesCollectionView.register(cellType: MovieCollectionViewCell.self)
        
        /// setup delegate and data source
        let collectionViews = [favoritesCollectionView]
        collectionViews.forEach { collectionView in
            guard let collectionView else { return }
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.collectionViewLayout = MovieCollectionViewLayout()
        }
    }
}

// MARK: - Collection View Delegate And Data Source
extension FavoriteVC: CollectionViewProtocols {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filteredMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: MovieCollectionViewCell.self, for: indexPath)
        let movieViewItem = viewModel.filteredMovies[indexPath.row]
        cell.configure(with: movieViewItem) { [weak self] isFavorite in
            self?.viewModel.removeFromFavorite(movieViewItem.movie)
        }
        return cell
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
