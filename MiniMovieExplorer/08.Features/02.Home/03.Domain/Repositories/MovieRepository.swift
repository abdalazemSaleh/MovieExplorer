protocol MovieRepository {
    func fetchPopularMovies(page: Int) async throws -> MovieResponse
    func fetchMovieDetails(id: Int) async throws -> MovieDetails
} 
