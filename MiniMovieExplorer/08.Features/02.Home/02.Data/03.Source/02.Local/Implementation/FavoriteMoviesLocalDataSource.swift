import Foundation
import SwiftData

final class FavoriteMoviesLocalDataSource: FavoriteMoviesDataSource {
    private var modelContext: ModelContext?
    
    init() {
        Task { @MainActor in
            do {
                let container = try ModelContainer(for: FavoriteMovie.self)
                self.modelContext = container.mainContext
            } catch {
                fatalError("Failed to create ModelContainer: \(error)")
            }
        }
    }

    func addToFavorites(_ movie: Movie) throws {
        guard let modelContext else {
            fatalError("Model context is nil")
        }
        
        let favoriteMovie = FavoriteMovie(from: movie)
        modelContext.insert(favoriteMovie)
        try modelContext.save()
    }
    
    func removeFromFavorites(_ movie: Movie) throws {
        guard let modelContext else {
            fatalError("Model context is nil")
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
        guard let modelContext else {
            fatalError("Model context is nil")
        }
        
        let descriptor = FetchDescriptor<FavoriteMovie>(
            predicate: #Predicate { $0.id == movie.id }
        )
        
        do {
            return try !(modelContext.fetch(descriptor).isEmpty )
        } catch {
            return false
        }
    }
    
    func getAllFavorites() throws -> [Movie] {
        guard let modelContext else {
            fatalError("Model context is nil")
        }

        let descriptor = FetchDescriptor<FavoriteMovie>(
            sortBy: [SortDescriptor(\.dateAdded, order: .reverse)]
        )
        return try modelContext.fetch(descriptor).map { $0.toMovie() }
    }
} 
