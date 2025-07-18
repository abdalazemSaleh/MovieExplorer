import Foundation
import SwiftData
import Combine

@MainActor
protocol HomeViewModelProtocol {
    /// functions
    func fetchPopularMovies() async
    func favoriteButtonTapped(_ movie: Movie, isFavorite: Bool)
    func isFavorite(_ movie: Movie) -> Bool
    /// navigation
    func showFavoritesPage()
    func showDetails(movieID: Int)
}

final class HomeViewModel: BaseViewModel {
    // MARK: - Properties
    private let fetchPopularMoviesUseCase: FetchPopularMoviesUseCase
    private let favoriteMovieRepository: FavoriteMovieRepository
    private let coordinator: HomeCoordinator
    
    
    // MARK: - Published Properties
    @Published var screenState: ScreenState = .loading
    @Published private(set) var movies: [MovieViewItem] = []
    @Published private(set) var filteredMovies: [MovieViewItem] = []
    @Published var searchText: String = "" {
        didSet {
            filterMovies()
        }
    }
    
    var isLoadingOtherPages = false
    
    // MARK: - Init
    init(
        fetchPopularMoviesUseCase: FetchPopularMoviesUseCase,
        favoriteMovieRepository: FavoriteMovieRepository,
        coordinator: HomeCoordinator
    ) {
        self.fetchPopularMoviesUseCase = fetchPopularMoviesUseCase
        self.favoriteMovieRepository = favoriteMovieRepository
        self.coordinator = coordinator
        super.init()
        Task {
            await fetchPopularMovies()
        }
    }
}

// MARK: - Public Methods
extension HomeViewModel: HomeViewModelProtocol {
    func fetchPopularMovies() async {
        do {
            screenState = .loading
            let newMovies = try await fetchPopularMoviesUseCase.execute(request: ())
            movies.append(contentsOf: newMovies)
            filterMovies()
        } catch {
            /// validate if error is in first api call show status view else show snakebar, this action for better user experiance
            handelError(error) { errorMessage in
                isLoadingOtherPages
                ?
                screenState = .error(errorMessage)
                :
                coordinator.showSnakeBar(message: errorMessage)
            }
        }
    }
    
    func favoriteButtonTapped(_ movie: Movie, isFavorite: Bool) {
        isFavorite ? addToFavorite(movie) : removeFromFavorite(movie)
    }
    
    func isFavorite(_ movie: Movie) -> Bool {
        return favoriteMovieRepository.isFavorite(movie)
    }
}

// MARK: - Navigations
extension HomeViewModel {
    func showFavoritesPage() {
        coordinator.showFavoritesPage()
    }
    
    func showDetails(movieID: Int) {
        coordinator.showMovieDetailsPage(movieId: movieID)
    }
}

// MARK: - Pagination Functions
extension HomeViewModel {
    func loadMoreIfNeeded(currentItem: Int) {
        guard searchText.isEmpty else { return }
        guard fetchPopularMoviesUseCase.canLoadMore(),
              currentItem >= filteredMovies.count - 5 else { return }
        Task {
            await fetchPopularMovies()
        }
    }
    
    func resetPagination() {
        fetchPopularMoviesUseCase.reset()
        movies.removeAll()
        filteredMovies.removeAll()
    }
}

// MARK: - Private Methods
private extension HomeViewModel {
    func addToFavorite(_ movie: Movie) {
        do {
            try favoriteMovieRepository.addToFavorites(movie)
        } catch {
            print("Error managing favorites:", error.localizedDescription)
        }
    }
    
    func removeFromFavorite(_ movie: Movie) {
        do {
            try favoriteMovieRepository.removeFromFavorites(movie)
        } catch {
            print("Error managing favorites:", error.localizedDescription)
        }
    }
    
    func filterMovies() {
        defer { isLoadingOtherPages = true }
        if searchText.isEmpty {
            filteredMovies = movies
            screenState = filteredMovies.isEmpty ? .empty : .content
        } else {
            isLoadingOtherPages = false
            filteredMovies = movies.filter { movie in
                movie.movie.title.localizedCaseInsensitiveContains(searchText) ||
                movie.movie.overview.localizedCaseInsensitiveContains(searchText)
            }
            screenState = filteredMovies.isEmpty ? .empty : .content
        }
    }
}
