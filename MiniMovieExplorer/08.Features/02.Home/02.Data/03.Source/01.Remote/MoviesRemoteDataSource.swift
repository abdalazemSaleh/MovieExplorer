import NetworkLayer

//#error("confirm pagination")
class MoviesRemoteDataSource: BaseRemoteDataSource, MoviesDataSource {
    func fetchMovies(page: Int) async throws -> PaginationBaseModel<MovieEntity> {
        let endPoint = MoviesEndPoint.fetchPopularMovies(page: page)
        let request = RequestModel(endPoint: endPoint)
        let response: PaginationBaseModel<MovieEntity> = try await network.requestWithBase(request)
        return response
    }
    
    func fetchMovieDetails(for movieId: Int) async throws -> MovieDetailsEntity {
        let endPoint = MoviesEndPoint.fetchMovieDetails(id: movieId)
        let request = RequestModel(endPoint: endPoint)
        let response: MovieDetailsEntity = try await network.requestWithBase(request)
        return response
    }
}
