//
//  AppConfiguration.swift
//  MiniMovieExplorer
//
//  Created by Abdel Azim Saleh on 16/06/2025.
//


import NetworkLayer
import UIKit
import Resolver

class AppConfiguration {
    
    /// Network Layer
    struct NetworkLayerConfigurations {
        static func configure() async {
            let netowrkManager = NetworkConfigurationManager.shared
            await netowrkManager.setBaseURL("api.themoviedb.org")
            await netowrkManager.setResourcePath("3")
//            await netowrkManager.setApiVersion("v1")
            #if DEBUG
            await netowrkManager.setLoggerEnabled(true)
            #endif
        }
    }
        
    /// Configuration
    @MainActor static func configure(_ app: UIApplication) {
        Task {
            await NetworkLayerConfigurations.configure()
        }
    }
}
