//
//  ValidationResult.swift
//  MiniMovieExplorer
//
//  Created by Abdel Azim Saleh on 16/06/2025.
//


enum ValidationResult<T> {
    case success
    case fail(String, T)
}
