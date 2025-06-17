//
//  ItemsResponseEntity.swift
//  MiniMovieExplorer
//
//  Created by Abdel Azim Saleh on 16/06/2025.
//

struct ItemsResponseEntity<T: Codable>: Codable {
    let items: [T]
}
