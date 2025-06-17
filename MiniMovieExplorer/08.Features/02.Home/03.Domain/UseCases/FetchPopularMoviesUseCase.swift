final class FetchPopularMoviesUseCase: BaseUseCase {
    typealias Request = Void
    typealias Response = [MovieViewItem]

    private let movieRepository: MovieRepository
    private let favoritesRepository: FavoriteMovieRepository

    init(movieRepository: MovieRepository, favoritesRepository: FavoriteMovieRepository) {
        self.movieRepository = movieRepository
        self.favoritesRepository = favoritesRepository
    }

    func execute(request: Void) async throws -> [MovieViewItem] {
        let remoteMovies = try await movieRepository.fetchPopularMovies()
        let favoriteMovies = try favoritesRepository.getAllFavorites()

        let favoriteIDs = Set(favoriteMovies.map { $0.id })
        
        return remoteMovies.map { movie in
            MovieViewItem(movie: movie, isFavorite: favoriteIDs.contains(movie.id))
        }
    }
}
