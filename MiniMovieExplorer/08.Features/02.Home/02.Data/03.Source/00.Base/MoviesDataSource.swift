protocol MoviesDataSource {
    func fetchMovies() async throws -> [MovieEntity]
    func fetchMovieDetails(for movieId: Int) async throws -> MovieDetailsEntity
}
