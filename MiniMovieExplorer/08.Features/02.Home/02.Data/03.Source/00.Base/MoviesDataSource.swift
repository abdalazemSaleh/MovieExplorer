//
//  MoviesDataSource.swift
//  MiniMovieExplorer
//
//  Created by Abdel Azim Saleh on 17/06/2025.
//

protocol MoviesDataSource {
    func fetchMovies() async throws -> [MovieEntity]
    func fetchMovieDetails(for movieId: Int) async throws -> MovieDetailsEntity
}
