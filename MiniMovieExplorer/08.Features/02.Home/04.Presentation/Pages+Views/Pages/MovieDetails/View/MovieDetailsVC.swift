import UIKit

class MovieDetailsVC: BaseVC {
    
    // MARK: - IBOutlet
    @IBOutlet weak var headerView: MovieDetailsHeader!
    @IBOutlet weak var movieDetailsCard: MovieDetailsCard!
    @IBOutlet weak var movieDescrption: UILabel!
    @IBOutlet weak var prodcuctionCompaniesCollectionView: UICollectionView!
    // MARK: - Properties
    private var viewModel: MovieDetailsViewModel
    
    // MARK: -  Init
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    override func setupView() {
        setupHeaderView()
        configureCollectionViews()
        setupBindings()
    }
    
    private func setupHeaderView() {
        headerView.backButtonAction = { [weak self] in
            self?.viewModel.backButtonTapped()
        }
    }
    
    private func setupBindings() {
        viewModel.$movieDetails
            .sink { [weak self] movie in
                if let movie = movie {
                    self?.loadData(with: movie)
                }
            }
            .store(in: &subscription)
    }
    
    private func loadData(with movie: MovieDetails) {
        headerView.movie = movie
        movieDetailsCard.movie = movie
        movieDescrption.text = movie.overview
        prodcuctionCompaniesCollectionView.reloadData()
    }
}

// MARK: - Configure Collection Views
private extension MovieDetailsVC {
    func configureCollectionViews() {
        ///  register cells
        prodcuctionCompaniesCollectionView.register(cellType: ProductionCompanyCell.self)
        
        /// setup delegate and data source
        let collectionViews = [prodcuctionCompaniesCollectionView]
        collectionViews.forEach { collectionView in
            guard let collectionView else { return }
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
}

// MARK: - Collection View Delegate And Data Source
extension MovieDetailsVC: CollectionViewProtocols {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movieDetails?.productionCompanies.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: ProductionCompanyCell.self, for: indexPath)
        if let prodcuction = viewModel.movieDetails?.productionCompanies[indexPath.row] {
            cell.configure(with: prodcuction)
        }
        return cell
    }    
}
