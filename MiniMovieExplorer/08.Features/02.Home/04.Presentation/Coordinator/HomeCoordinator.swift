protocol HomeCoordinatorProtocol: Coordinator {
    func showHomePage()
    func showMovieDetailsPage(movieId: Int)
    func showFavoritesPage()
}

final class HomeCoordinator: HomeCoordinatorProtocol {
    
    var router: Router
    let movieConainer: MovieDependencyContainer
    
    init(router: Router) {
        self.router = router
        self.movieConainer = MovieDependencyContainer()
    }
    
    func start() {
        showHomePage()
    }
    
    func showHomePage() {
        let viewController = movieConainer.makeHomeViewController(coordinator: self)
        router.push(viewController)
    }
    
    func showMovieDetailsPage(movieId: Int) {
        
    }
    
    func showFavoritesPage() {
        let viewController = movieConainer.makeFavoritesViewController(coordinator: self)
        router.push(viewController)
    }
}
