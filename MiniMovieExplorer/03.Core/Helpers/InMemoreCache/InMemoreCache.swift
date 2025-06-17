//
//  InMemoreCache.swift
//  eTrip
//
//  Created by Abdalazem Saleh on 25/11/2024.
//

import Foundation

actor InMemoryCache<Key: Hashable, Value> {
    private var cache = [Key: Value]()

    func get(forKey key: Key) -> Value? {
        return cache[key]
    }
    
    func set(_ value: Value, forKey key: Key) {
        cache[key] = value
    }
    
    func clear(forKey key: Key) {
        cache.removeValue(forKey: key)
    }
    
    func clearAll() {
        cache.removeAll()
    }
}
