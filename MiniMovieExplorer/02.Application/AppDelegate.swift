import UIKit
import SwiftData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var container: ModelContainer!
    var modelContext: ModelContext!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        AppConfiguration.configure(application)
        
        container = try! ModelContainer(for: FavoriteMovie.self)
        modelContext = container.mainContext
        
        return true
    }    
}
