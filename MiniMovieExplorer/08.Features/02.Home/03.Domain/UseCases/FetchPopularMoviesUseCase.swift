final class FetchPopularMoviesUseCase: BaseUseCase {
    // MARK: - Typealias
    typealias Request = Void
    typealias Response = [MovieViewItem]
    
    // MARK: - Properties
    /// repositories
    private let movieRepository: MovieRepository
    private let favoritesRepository: FavoriteMovieRepository
    /// pagination properties
    private var currentPage = 1
    private var isLoading = false
    private var hasMorePages = true

    // MARK: - Init
    init(movieRepository: MovieRepository, favoritesRepository: FavoriteMovieRepository) {
        self.movieRepository = movieRepository
        self.favoritesRepository = favoritesRepository
    }

    // MARK: - Public Methods
    func execute(request: Void) async throws -> [MovieViewItem] {
        guard !isLoading && hasMorePages else { return [] }
        
        isLoading = true
        defer { isLoading = false }
        
        let remoteMovies = try await movieRepository.fetchPopularMovies(page: currentPage)
        let favoriteMovies = try favoritesRepository.getAllFavorites()
        
        let favoriteIDs = Set(favoriteMovies.map { $0.id })
                
        /// update pagination data
        hasMorePages = remoteMovies.hasMorePages
        if hasMorePages {
            currentPage += 1
        }
        
        /// prepare movie items to return
        return remoteMovies.movies.map { movie in
            MovieViewItem(movie: movie, isFavorite: favoriteIDs.contains(movie.id))
        }    
    }
        
    func reset() {
        currentPage = 1
        isLoading = false
        hasMorePages = true
    }
    
    func canLoadMore() -> Bool {
        return !isLoading && hasMorePages
    }
}
