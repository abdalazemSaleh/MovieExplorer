enum ValidationResult<T> {
    case success
    case fail(String, T)
}
