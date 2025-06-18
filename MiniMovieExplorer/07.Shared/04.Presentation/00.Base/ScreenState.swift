import Foundation

public enum ScreenState: Equatable {
    case loading
    case error(String?)
    case empty
    case content

    public static func == (lhs: ScreenState, rhs: ScreenState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading), (.empty, .empty), (.content, .content):
            return true
        case (.error(let l), .error(let r)):
            return l == r
        default:
            return false
        }
    }
} 