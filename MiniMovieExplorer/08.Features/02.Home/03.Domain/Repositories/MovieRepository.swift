import Foundation

protocol MovieRepository {
    func fetchPopularMovies() async throws -> [Movie]
    func fetchMovieDetails(id: Int) async throws -> MovieDetails
} 
