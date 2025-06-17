//
//  ResolverSetup.swift
//  MiniMovieExplorer
//
//  Created by Abdel Azim Saleh on 16/06/2025.
//


import Resolver
import UIKit

extension Resolver: @retroactive ResolverRegistering {
    public static func registerAllServices() {
        /// register main app components
        register { UINavigationController() as UINavigationController }.scope(.application)
        register { AppRouter() as Router }
    }
}
