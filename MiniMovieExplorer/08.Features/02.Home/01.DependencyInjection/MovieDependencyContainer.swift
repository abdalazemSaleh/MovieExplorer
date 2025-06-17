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
        return FetchPopularMoviesUseCase(repository: makeMovieRepository())
    }
    
    func makeFetchMovieDetailsUseCase() -> FetchMovieDetailsUseCase {
        return FetchMovieDetailsUseCase(repository: makeMovieRepository())
    }
    
    // MARK: - View Models
    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel(
            fetchPopularMoviesUseCase: makeFetchPopularMoviesUseCase(),
            favoriteMovieRepository: makeFavoriteMovieRepository()
        )
    }
    
    // MARK: - View Controller
    func makeHomeViewController() -> HomeVC {
        return HomeVC(viewModel: makeHomeViewModel())
    }
}
