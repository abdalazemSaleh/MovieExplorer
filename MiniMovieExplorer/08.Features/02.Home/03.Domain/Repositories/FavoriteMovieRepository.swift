protocol FavoriteMovieRepository {
    func addToFavorites(_ movie: Movie) throws
    func removeFromFavorites(_ movie: Movie) throws
    func isFavorite(_ movie: Movie) -> Bool
    func getAllFavorites() throws -> [Movie]
}
