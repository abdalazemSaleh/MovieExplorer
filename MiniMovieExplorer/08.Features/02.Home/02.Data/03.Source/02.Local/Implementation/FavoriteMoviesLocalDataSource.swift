import Foundation
import SwiftData

final class FavoriteMoviesLocalDataSource: FavoriteMoviesDataSource {
    var container: ModelContainer?
    var modelContext: ModelContext?
    
    init() {
        do {
            container = try ModelContainer(for: FavoriteMovie.self)
            if let container {
                modelContext = ModelContext(container)
            }
        } catch {
            print("Error initializing database container:", error)
        }
    }
    
    func addToFavorites(_ movie: Movie) throws {
        guard let modelContext else {
            throw NSError(domain: "FavoriteMoviesLocalDataSource", code: -1, userInfo: [NSLocalizedDescriptionKey: "Model context is not initialized"])
        }
        
        let favoriteMovie = FavoriteMovie(from: movie)
        modelContext.insert(favoriteMovie)
        try modelContext.save()
    }
    
    func removeFromFavorites(_ movie: Movie) throws {
        guard let modelContext else {
            throw NSError(domain: "FavoriteMoviesLocalDataSource", code: -1, userInfo: [NSLocalizedDescriptionKey: "Model context is not initialized"])
        }
        
        let descriptor = FetchDescriptor<FavoriteMovie>(
            predicate: #Predicate { $0.id == movie.id }
        )
        
        if let favoriteMovie = try modelContext.fetch(descriptor).first {
            modelContext.delete(favoriteMovie)
            try modelContext.save()
        }
    }
    
    func isFavorite(_ movie: Movie) -> Bool {
        guard let modelContext else { return false }
        
        let descriptor = FetchDescriptor<FavoriteMovie>(
            predicate: #Predicate { $0.id == movie.id }
        )
        
        do {
            return try !modelContext.fetch(descriptor).isEmpty
        } catch {
            return false
        }
    }
    
    func getAllFavorites() throws -> [Movie] {
        guard let modelContext else {
            throw NSError(domain: "FavoriteMoviesLocalDataSource", code: -1, userInfo: [NSLocalizedDescriptionKey: "Model context is not initialized"])
        }
        
        let descriptor = FetchDescriptor<FavoriteMovie>(
            sortBy: [SortDescriptor(\.dateAdded, order: .reverse)]
        )
        return try modelContext.fetch(descriptor).map { $0.toMovie() }
    }
} 
