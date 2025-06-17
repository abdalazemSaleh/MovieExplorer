import NetworkLayer

protocol AuthorizedEndpoint {
    var authorizationHeader: String { get }
}

#warning("Set token in app configuration")
extension AuthorizedEndpoint {
    var authorizationHeader: String {
        do {
            let token = try TokenManager.shared.getToken()
            return "Bearer \(token)"
        } catch {
            let defaultToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwYmZmOWM2OTVlMGQ0OTRkZmZhMjgxZTI1YmVkMDEyMCIsIm5iZiI6MTc1MDA5NTI4NS4wNzksInN1YiI6IjY4NTA1NWI1MTM1MmM3MzUyMmI5OWU0ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.R8dtQhciK1u5WClEfIrbo-orPwMpmqIgNJG9bU7FyxU"
            try? TokenManager.shared.saveToken(defaultToken)
            return "Bearer \(defaultToken)"
        }
    }
} 
