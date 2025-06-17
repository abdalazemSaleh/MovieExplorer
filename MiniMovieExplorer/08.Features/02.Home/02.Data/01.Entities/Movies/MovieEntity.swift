struct MovieEntity: MovieSummaryProtocol {
    let id: Int?
    let adult: Bool?
    let backdropPath: String?
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

protocol MovieSummaryProtocol: Codable {
    var id: Int? { get }
    var adult: Bool? { get }
    var backdropPath: String? { get }
    var originalLanguage: String? { get }
    var originalTitle: String? { get }
    var overview: String? { get }
    var popularity: Double? { get }
    var posterPath: String? { get }
    var releaseDate: String? { get }
    var title: String? { get }
    var video: Bool? { get }
    var voteAverage: Double? { get }
    var voteCount: Int? { get }
}
