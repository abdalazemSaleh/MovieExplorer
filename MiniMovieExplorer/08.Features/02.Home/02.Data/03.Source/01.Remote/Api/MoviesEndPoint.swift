import NetworkLayer

// MARK: - Cases
enum MoviesEndPoint: EndPoint, AuthorizedEndpoint {
    case fetchPopularMovies
    case fetchMovieDetails(id: Int)
}

// MARK: - Paths
extension MoviesEndPoint {
    var clientName: String {
        "movie"
    }
    
    var path: String {
        switch self {
        case .fetchPopularMovies:
            return "popular"
        case .fetchMovieDetails(let id):
            return "\(id)"
        }
    }
}

// MARK: - Methods
extension MoviesEndPoint {
    var method: HTTPMethod {
        .get
    }
}

// MARK: - Header
extension MoviesEndPoint {
    var headers: Headers {
        return [
            "Authorization": authorizationHeader
        ]
    }
}

