protocol BaseUseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request) async throws -> Response
}

protocol NonReturnBaseUseCase {
    associatedtype Request
    
    func execute(request: Request) async throws
}
