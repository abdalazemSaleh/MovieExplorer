import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    let backdropPath: String
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
        
    // MARK: - Computed Properties
    var posterURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
    
    var backdropURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/original\(backdropPath)")
    }
    
    var formattedReleaseDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: releaseDate) else { return releaseDate }
        
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
} 
