//
//  HomeViewModel.swift
//  MiniMovieExplorer
//
//  Created by Abdel Azim Saleh on 16/06/2025.
//

import Foundation
import SwiftData

@MainActor
protocol HomeViewModelProtocol {
    func fetchPopularMovies() async
    func favoriteButtonTapped(_ movie: Movie, isFavorite: Bool)
    func isFavorite(_ movie: Movie) -> Bool
}

final class HomeViewModel: BaseViewModel {
    // MARK: - Properties
    private let fetchPopularMoviesUseCase: FetchPopularMoviesUseCase
    private let favoriteMovieRepository: FavoriteMovieRepository
    
    // MARK: - Published Properties
    @Published private(set) var movies: [MovieViewItem] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    
    // MARK: - Init
    init(fetchPopularMoviesUseCase: FetchPopularMoviesUseCase,
         favoriteMovieRepository: FavoriteMovieRepository) {
        self.fetchPopularMoviesUseCase = fetchPopularMoviesUseCase
        self.favoriteMovieRepository = favoriteMovieRepository
    }
}

// MARK: - Public Methods
extension HomeViewModel: HomeViewModelProtocol {
    func fetchPopularMovies() async {
        do {
            let result = try await fetchPopularMoviesUseCase.execute(request: ())
            movies = result
        } catch {
            print("Error is", error.localizedDescription)
        }
    }
    
    func favoriteButtonTapped(_ movie: Movie, isFavorite: Bool) {
        do {
            if isFavorite {
                try favoriteMovieRepository.addToFavorites(movie)
            } else {
                try favoriteMovieRepository.removeFromFavorites(movie)
            }
        } catch {
            print("Error managing favorites:", error.localizedDescription)
        }
    }
    
    func isFavorite(_ movie: Movie) -> Bool {
        return favoriteMovieRepository.isFavorite(movie)
    }
}

// MARK: - Private Methods
private extension HomeViewModel {
    func addToFavorite(_ movie: Movie) {
        print("Add to favorite")
    }
    
    func removeFromFavorite(_ movie: Movie) {
        print("Remove from favorite")
    }
}
