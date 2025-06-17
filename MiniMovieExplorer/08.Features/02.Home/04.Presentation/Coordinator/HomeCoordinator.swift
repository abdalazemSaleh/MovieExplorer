//
//  HomeCoordinator.swift
//  MiniMovieExplorer
//
//  Created by Abdel Azim Saleh on 16/06/2025.
//

protocol HomeCoordinatorProtocol: Coordinator {
    func showHomePage()
    func showMovieDetailsPage(movieId: Int)
    func showFavoritesPage()
}

final class HomeCoordinator: HomeCoordinatorProtocol {
    
    @Injected var router: any Router
    let movieConainer: MovieDependencyContainer
    
    init() {
        //        self.router = router
        self.movieConainer = MovieDependencyContainer()
    }
    
    func start() {
        showHomePage()
    }
    
    func showHomePage() {
        let viewController = movieConainer.makeHomeViewController()
        router.push(viewController)
    }
    
    func showMovieDetailsPage(movieId: Int) {
        
    }
    
    func showFavoritesPage() {
        
    }
}
