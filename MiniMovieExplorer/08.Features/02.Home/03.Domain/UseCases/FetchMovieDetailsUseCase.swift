final class FetchMovieDetailsUseCase: BaseUseCase {
    typealias Request = Int
    typealias Response = MovieDetails
    
    private let repository: MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }

    func execute(request: Request) async throws -> Response {
        return try await repository.fetchMovieDetails(id: request)
    }
    
}
