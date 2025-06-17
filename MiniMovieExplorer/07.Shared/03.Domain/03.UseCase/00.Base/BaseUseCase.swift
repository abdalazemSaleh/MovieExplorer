//
//  BaseUseCase.swift
//  MiniMovieExplorer
//
//  Created by Abdel Azim Saleh on 16/06/2025.
//


protocol BaseUseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request) async throws -> Response
}

protocol NonReturnBaseUseCase {
    associatedtype Request
    
    func execute(request: Request) async throws
}
