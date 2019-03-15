import Reachability
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let reachability = Reachability()

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // Initializing the Root ViewController for working with CodeView
        window = UIWindow(frame: UIScreen.main.bounds)

        //let cardListRouter = CardListRouter()
        let favoritesRouter = FavoritesRouter()

        //let rootViewController = MagicTabBarController(viewControllers: [cardListRouter.presenter.view, favoritesRouter.presenter.view])
        let rootViewController = MagicTabBarController(viewControllers: [favoritesRouter.presenter.view])
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()

        startReachability()

        return true
    }
}

// MARK: - Recheability

extension AppDelegate {
    func startReachability() {
        do {
            try reachability?.startNotifier()

            reachability?.whenUnreachable = { _ in
                let alert = self.alert(tiltle: "Connection Warning", message: "Internet is unreachable")

                self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }

        } catch {
            Logger.logError(in: self, message: error.localizedDescription)
        }
    }

    func alert(tiltle: String? = nil, message: String? = nil, actions: [UIAlertAction]? = nil) -> UIAlertController {
        let alert = UIAlertController(title: tiltle, message: message, preferredStyle: .alert)

        if let actions = actions {
            for action in actions {
                alert.addAction(action)
            }
        } else {
            alert.addAction(
                UIAlertAction(title: "Ok", style: .default, handler: { _ in
                    alert.dismiss(animated: true, completion: nil)
                })
            )
        }

        return alert
    }
}
