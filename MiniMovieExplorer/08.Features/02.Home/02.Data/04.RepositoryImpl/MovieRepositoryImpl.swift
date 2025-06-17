import Foundation

final class MovieRepositoryImpl: MovieRepository {
    private let dataSource: MoviesDataSource
    
    init(dataSource: MoviesDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchPopularMovies(page: Int) async throws -> MovieResponse {
        let response = try await dataSource.fetchMovies(page: page)
        return MovieMapper.map(response)
    }
    
    func fetchMovieDetails(id: Int) async throws -> MovieDetails {
        let response = try await dataSource.fetchMovieDetails(for: id)
        return MovieMapper.map(response)
    }
}
