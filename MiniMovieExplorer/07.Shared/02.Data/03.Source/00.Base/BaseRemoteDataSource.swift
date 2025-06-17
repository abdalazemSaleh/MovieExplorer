//
//  BaseRemoteDataSource.swift
//  MiniMovieExplorer
//
//  Created by Abdel Azim Saleh on 16/06/2025.
//

import Foundation
import NetworkLayer

class BaseRemoteDataSource {
    let network = APIRequestHandler()
    
    func extractData<T>(_ response: BaseModel<T>) throws -> T {
        guard response.status == .success, let data = response.data else {
            throw NetworkError.customError(error: response.message ?? "defult_error.m".localized(from: .MainApp))
        }
        return data
    }
    
    func checkResponse(_ response: BaseModel<EmptyEntity>) throws {
        guard response.status == .success else {
            throw NetworkError.customError(error: response.message ?? "defult_error.m".localized(from: .MainApp))
        }
    }
}

