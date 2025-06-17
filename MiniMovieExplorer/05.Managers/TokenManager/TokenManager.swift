import Foundation

enum TokenError: Error {
    case tokenNotFound
    case invalidToken
}

final class TokenManager {
    static let shared = TokenManager()
    
    private let keychainManager = KeychainManager.shared
    private let tokenKey = "movie_api_token"
    
    private init() {}
    
    // MARK: - Token Management
    func saveToken(_ token: String) throws {
        try keychainManager.save(token, forKey: tokenKey)
    }
    
    func getToken() throws -> String {
        do {
            return try keychainManager.retrieve(forKey: tokenKey)
        } catch {
            throw TokenError.tokenNotFound
        }
    }
    
    func deleteToken() throws {
        try keychainManager.delete(forKey: tokenKey)
    }
    
    // MARK: - Token Validation
    func isValidToken(_ token: String) -> Bool {
        return !token.isEmpty
    }
} 
