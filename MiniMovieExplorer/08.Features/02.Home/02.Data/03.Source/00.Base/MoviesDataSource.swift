protocol MoviesDataSource {
    func fetchMovies(page: Int) async throws -> PaginationBaseModel<MovieEntity>
    func fetchMovieDetails(for movieId: Int) async throws -> MovieDetailsEntity
}
