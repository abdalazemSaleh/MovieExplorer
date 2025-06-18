struct PaginationBaseModel<T: Codable>: Codable {
    let page: Int?
    let results: [T]?
    let totalPages, totalResults: Int?
    let success: Bool?
    let statusMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case success
        case statusMessage = "status_message"
    }
}
