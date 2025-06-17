import Foundation

extension String {
    var asURL: URL? {
        return URL(string: self)
    }
}
