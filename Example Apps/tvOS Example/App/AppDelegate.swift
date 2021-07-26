import UIKit
import SparrowKit

@main
class AppDelegate: SPAppWindowDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let rootController = PreviewController().wrapToNavigationController(prefersLargeTitles: true)
        makeKeyAndVisible(viewController: rootController, tint: .systemBlue)
        return true
    }
}
