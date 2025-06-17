//
//  ResolverHelper.swift
//  MiniMovieExplorer
//
//  Created by Abdel Azim Saleh on 16/06/2025.
//


import Resolver

// MARK: - Resolver Helper
class ResolverHelper {
    static func resolve<T>(_ type: T.Type = T.self) -> T {
        return Resolver.resolve()
    }
}

