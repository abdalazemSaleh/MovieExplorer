struct ItemsResponseEntity<T: Codable>: Codable {
    let items: [T]
}
