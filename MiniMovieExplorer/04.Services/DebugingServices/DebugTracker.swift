import Foundation

public class DebugTracker {
    static var trackedObjects = [ObjectIdentifier: String]()
    
    static func track(object: AnyObject) {
        #if DEBUG
        let id = ObjectIdentifier(object)
        trackedObjects[id] = "\(type(of: object)) - \(Unmanaged.passUnretained(object).toOpaque())"
        #endif
    }
    
    static func untrack(object: AnyObject) {
        #if DEBUG
        let id = ObjectIdentifier(object)
        trackedObjects.removeValue(forKey: id)
        #endif
        
    }
    
    static func printTrackedObjects() {
        #if DEBUG
        print(trackedObjects)
        #endif
    }
}
