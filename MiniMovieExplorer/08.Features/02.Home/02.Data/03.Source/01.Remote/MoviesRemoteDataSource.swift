//
//  MoviesRemoteDataSource.swift
//  MiniMovieExplorer
//
//  Created by Abdel Azim Saleh on 17/06/2025.
//

import NetworkLayer

class MoviesRemoteDataSource: BaseRemoteDataSource, MoviesDataSource {    
    func fetchMovies() async throws -> [MovieEntity] {
        let endPoint = MoviesEndPoint.fetchPopularMovies
        let request = RequestModel(endPoint: endPoint)
        let response: PaginationBaseModel<MovieEntity> = try await network.requestWithBase(request)
        return response.results
    }
    
    func fetchMovieDetails(for movieId: Int) async throws -> MovieDetailsEntity {
        let endPoint = MoviesEndPoint.fetchPopularMovies
        let request = RequestModel(endPoint: endPoint)
        let response: MovieDetailsEntity = try await network.requestWithBase(request)
        return response
    }
}
