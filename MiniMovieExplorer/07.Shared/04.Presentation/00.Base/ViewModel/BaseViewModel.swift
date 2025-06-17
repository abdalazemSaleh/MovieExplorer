//
//  BaseViewModel.swift
//  AseerAlkotb
//
//  Created by Abdalazem Saleh on 03/02/2025.
//

import Foundation
import Combine
import NetworkLayer

class BaseViewModel {
    // MARK: - Propertys
    var subscription = Set<AnyCancellable>()
    
    // MARK: - Deinit
    init() {
        configureInputObservers()
        configureOutputObservers()
    }
    
    deinit {
        subscription.removeAll()
    }
    
    // MARK: - Helper Functions
    func handelError(_ error: Error, errorMessage: (String) -> Void) {
        if let error = error as? NetworkError {
            errorMessage(error.description)
        } else {
            errorMessage(error.localizedDescription)
        }
    }
}

extension BaseViewModel {
    @objc func configureInputObservers() {
    }
    
    @objc func configureOutputObservers() {
        
    }
}
