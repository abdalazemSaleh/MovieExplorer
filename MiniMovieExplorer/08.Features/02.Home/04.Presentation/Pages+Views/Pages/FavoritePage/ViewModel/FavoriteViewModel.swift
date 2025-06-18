import Foundation
import SwiftData

@MainActor
protocol FavoriteViewModelProtocol {
    /// functions
    func fetchFavoriteMovies() async
    func removeFromFavorite(_ movie: Movie) async
    /// navigation
    func backButtonTapped()
}

final class FavoriteViewModel: BaseViewModel {
    // MARK: - Properties
    private let favoriteMovieRepository: FavoriteMovieRepository
    private let coordinator: HomeCoordinator
    
    // MARK: - Published Properties
    @Published private(set) var movies: [MovieViewItem] = []
    @Published private(set) var filteredMovies: [MovieViewItem] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    @Published var searchText: String = "" {
        didSet {
            filterMovies()
        }
    }
    
    // MARK: - Init
    init(
        favoriteMovieRepository: FavoriteMovieRepository,
        coordinator: HomeCoordinator
    ) {
        self.favoriteMovieRepository = favoriteMovieRepository
        self.coordinator = coordinator
        super.init()
        Task {
            await fetchFavoriteMovies()
        }
    }
}

// MARK: - Public Methods
extension FavoriteViewModel: FavoriteViewModelProtocol {
    func fetchFavoriteMovies() async {
        do {
            let favoriteMovies = try favoriteMovieRepository.getAllFavorites()
            movies = favoriteMovies.map { movie in
                MovieViewItem(movie: movie, isFavorite: true)
            }
            filterMovies()
        } catch {
            print("Error managing favorites:", error.localizedDescription)
        }
    }
    
    func removeFromFavorite(_ movie: Movie) {
        do {
            try favoriteMovieRepository.removeFromFavorites(movie)
            movies.removeAll(where: { $0.movie.id == movie.id })
            filterMovies()
        } catch {
            print("Error managing favorites:", error.localizedDescription)
        }
    }
    
    func backButtonTapped() {
        coordinator.pop()
    }
}

// MARK: - Private Methods
private extension FavoriteViewModel {
    func filterMovies() {
        if searchText.isEmpty {
            filteredMovies = movies
        } else {
            filteredMovies = movies.filter { movie in
                movie.movie.title.localizedCaseInsensitiveContains(searchText) ||
                movie.movie.overview.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}
