import NetworkLayer
import Foundation

// MARK: - Cases
enum MoviesEndPoint: EndPoint, AuthorizedEndpoint {
    case fetchPopularMovies(page: Int)
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

// MARK: - Params
extension MoviesEndPoint {
    var parameters: [URLQueryItem] {
        switch self {
        case .fetchPopularMovies(let page):
            return [.init(name: "page", value: String(page))]
        default: return []
        }
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

