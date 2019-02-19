//
//  AppDelegate.swift
//  magicbyirineu
//
//  Created by daniel.da.cunha.lima on 15/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit
import Reachability

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let reachability = Reachability()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Initializing the Root ViewController for working with CodeView
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        
        //Card List View Controller
        let router = CardListRouter()
        let rootViewController = router.presenter.view
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
        
        //Favorites View Controller
         
        
        /*
        let rootViewController = MagicTabBarController()
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
         */
        
        self.startReachability()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        self.reachability?.stopNotifier()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        self.startReachability()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


//MARK - Recheability
extension AppDelegate {
    
    func startReachability() {
        do {
            try self.reachability?.startNotifier()
            
            self.reachability?.whenUnreachable = { _ in
                let alert = self.alert(tiltle: "Connection Warning", message: "Internet is unreachable")
                
                self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
            
        } catch {
            Logger.logError(in: self, message: error.localizedDescription)
        }
    }
    
    func alert(tiltle:String? = nil, message:String? = nil, actions:[UIAlertAction]? = nil) -> UIAlertController {
        let alert = UIAlertController(title: tiltle, message: message, preferredStyle: .alert)
        
        if let actions = actions {
            for action in actions {
                alert.addAction(action)
            }
        }else{
            alert.addAction(
                UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                    alert.dismiss(animated: true, completion: nil)
                })
            )
        }
        
        return alert
    }
}
