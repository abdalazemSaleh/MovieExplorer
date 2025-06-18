import Foundation
import UIKit
import SwiftData

final class MovieDependencyContainer {    
    // MARK: - Data Source
    func makeMoviesDataSource() -> MoviesDataSource {
        return MoviesRemoteDataSource()
    }
    
    func makeFavoriteMoviesDataSource() -> FavoriteMoviesDataSource {
        return FavoriteMoviesLocalDataSource()
    }
    
    // MARK: - Repository
    func makeMovieRepository() -> MovieRepository {
        return MovieRepositoryImpl(dataSource: makeMoviesDataSource())
    }
    
    func makeFavoriteMovieRepository() -> FavoriteMovieRepository {
        return FavoriteMovieRepositoryImpl(dataSource: makeFavoriteMoviesDataSource())
    }
    
    // MARK: - Use Cases
    func makeFetchPopularMoviesUseCase() -> FetchPopularMoviesUseCase {
        return FetchPopularMoviesUseCase(
            movieRepository: makeMovieRepository(),
            favoritesRepository: makeFavoriteMovieRepository()
        )
    }
    
    func makeFetchMovieDetailsUseCase() -> FetchMovieDetailsUseCase {
        return FetchMovieDetailsUseCase(repository: makeMovieRepository())
    }
    
    // MARK: - View Models
    func makeHomeViewModel(coordinator: HomeCoordinator) -> HomeViewModel {
        return HomeViewModel(
            fetchPopularMoviesUseCase: makeFetchPopularMoviesUseCase(),
            favoriteMovieRepository: makeFavoriteMovieRepository(),
            coordinator: coordinator
        )
    }
    
    func makeFavoriteViewModel(coordinator: HomeCoordinator) -> FavoriteViewModel {
        return FavoriteViewModel(
            favoriteMovieRepository: makeFavoriteMovieRepository(),
            coordinator: coordinator
        )
    }
    
    // MARK: - View Controller
    func makeHomeViewController(coordinator: HomeCoordinator) -> HomeVC {
        return HomeVC(viewModel: makeHomeViewModel(coordinator: coordinator))
    }
    
    func makeFavoritesViewController(coordinator: HomeCoordinator) -> FavoriteVC {
        return FavoriteVC(viewModel: makeFavoriteViewModel(coordinator: coordinator))
    }
}
