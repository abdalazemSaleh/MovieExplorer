import Foundation
import SwiftData

@MainActor
protocol MovieDetailsViewModelProtocol {
    /// functions
    func fetchMovieDetails() async
    func backButtonTapped()
}

final class MovieDetailsViewModel: BaseViewModel {
    
    // MARK: - Properties
    private let fetchMovieDetailsUseCase: FetchMovieDetailsUseCase
    private let coordinator: HomeCoordinatorProtocol
    private let movieID: Int
    
    // MARK: - Published Properties
    @Published private(set) var movieDetails: MovieDetails?
    @Published private(set) var filteredMovies: [MovieViewItem] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    
    // MARK: - Init
    init(
        fetchMovieDetailsUseCase: FetchMovieDetailsUseCase,
        coordinator: HomeCoordinatorProtocol,
        movieID: Int
    ) {
        self.fetchMovieDetailsUseCase = fetchMovieDetailsUseCase
        self.coordinator = coordinator
        self.movieID = movieID
        super.init()
        Task {
            await fetchMovieDetails()
        }
    }
}

// MARK: - Public Methods
extension MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    func fetchMovieDetails() async {
        do {
            let movie = try await fetchMovieDetailsUseCase.execute(request: movieID)
            movieDetails = movie
        } catch {
            print("Error is", error.localizedDescription)
        }
    }
    
    func backButtonTapped() {
        coordinator.pop()
    }
}
