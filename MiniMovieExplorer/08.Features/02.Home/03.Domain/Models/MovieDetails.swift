import Foundation

struct MovieDetails {
    // Base movie information
    let movie: Movie
    // Additional properties for detailed movie information
    let runtime: Int
    let genres: [Genre]
    let productionCompanies: [ProductionCompany]
    let spokenLanguages: [Language]
    let budget: Int
    let revenue: Int
    let tagline: String
    let status: String
    let homepage: String
        
    // MARK: - Computed Properties
    var formattedRuntime: String {
        let hours = runtime / 60
        let minutes = runtime % 60
        return "\(hours)h \(minutes)m"
    }
    
    var formattedBudget: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: NSNumber(value: budget)) ?? "$0"
    }
    
    var formattedRevenue: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: NSNumber(value: revenue)) ?? "$0"
    }
    
    // MARK: - Convenience Properties
    var id: Int { movie.id }
    var title: String { movie.title }
    var overview: String { movie.overview }
    var posterPath: String? { movie.posterPath }
    var backdropPath: String? { movie.backdropPath }
    var releaseDate: String { movie.releaseDate }
    var voteAverage: Double { movie.voteAverage }
    var voteCount: Int { movie.voteCount }
    var posterURL: URL? { movie.posterURL }
    var backdropURL: URL? { movie.backdropURL }
    var formattedReleaseDate: String { movie.formattedReleaseDate }
}

// MARK: - Supporting Types
struct Genre: Codable {
    let id: Int
    let name: String
}

struct ProductionCompany: Codable {
    let id: Int
    let name: String
    let logoPath: String?
    let originCountry: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
    
    var logoURL: URL? {
        guard let logoPath = logoPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w200\(logoPath)")
    }
}

struct Language: Codable {
    let englishName: String
    let iso6391: String
    
    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso6391 = "iso_639_1"
    }
} 
