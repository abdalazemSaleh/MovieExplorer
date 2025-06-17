import Foundation
import SwiftData

@Model
final class FavoriteMovie {
    var id: Int
    var title: String
    var overview: String
    var posterPath: String
    var backdropPath: String
    var releaseDate: String
    var voteAverage: Double
    var voteCount: Int
    var dateAdded: Date
    
    init(from movie: Movie) {
        self.id = movie.id
        self.title = movie.title
        self.overview = movie.overview
        self.posterPath = movie.posterPath
        self.backdropPath = movie.backdropPath
        self.releaseDate = movie.releaseDate
        self.voteAverage = movie.voteAverage
        self.voteCount = movie.voteCount
        self.dateAdded = Date()
    }
    
    func toMovie() -> Movie {
        return Movie(
            id: id,
            title: title,
            overview: overview,
            posterPath: posterPath,
            backdropPath: backdropPath,
            releaseDate: releaseDate,
            voteAverage: voteAverage,
            voteCount: voteCount
        )
    }
}
