final class FetchPopularMoviesUseCase: BaseUseCase {
    typealias Request = Void
    typealias Response = [Movie]
    
    private let repository: MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }

    func execute(request: Void) async throws -> [Movie] {
        return try await repository.fetchPopularMovies()
    }
}
