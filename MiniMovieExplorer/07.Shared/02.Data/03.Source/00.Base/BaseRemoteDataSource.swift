import Foundation
import NetworkLayer

#warning("Error handling base on message if exists")
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

