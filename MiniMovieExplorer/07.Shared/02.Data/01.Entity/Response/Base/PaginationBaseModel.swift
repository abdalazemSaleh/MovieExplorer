//
//  PaginationBaseModel.swift
//  MiniMovieExplorer
//
//  Created by Abdel Azim Saleh on 17/06/2025.
//


struct PaginationBaseModel<T: Codable>: Codable {
    let page: Int
    let results: [T]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
