import Foundation

extension Int {
    func toHourMinuteFormat() -> String {
        let hours = self / 60
        let minutes = self % 60
        return String(format: "%02d:%02d", hours, minutes)
    }
}
