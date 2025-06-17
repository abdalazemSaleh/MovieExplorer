import Foundation

struct UserDefultsWrapped {
    @UserDefaultsWrapper(key: "isFirstLaunch", defaultValue: true)
    static var isFirstLaunch: Bool
}
