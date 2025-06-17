import Foundation
import SwiftData

final class FavoriteMovieRepositoryImpl: FavoriteMovieRepository {
    
    private var dataSource: FavoriteMoviesDataSource
    
    init(dataSource: FavoriteMoviesDataSource) {
        self.dataSource = dataSource
    }
        
    func addToFavorites(_ movie: Movie) throws {
        try dataSource.addToFavorites(movie)
    }
    
    func removeFromFavorites(_ movie: Movie) throws {
        try dataSource.removeFromFavorites(movie)
    }
    
    func isFavorite(_ movie: Movie) -> Bool {
        try dataSource.isFavorite(movie)
    }
    
    func getAllFavorites() throws -> [Movie] {
        try dataSource.getAllFavorites()
    }
}
