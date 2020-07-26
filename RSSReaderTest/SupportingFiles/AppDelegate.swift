import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = window ?? UIWindow(frame: UIScreen.main.bounds)
        
        let navController = UINavigationController(rootViewController: NewsVC())
        navController.navigationBar.prefersLargeTitles = true
        
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }


}

