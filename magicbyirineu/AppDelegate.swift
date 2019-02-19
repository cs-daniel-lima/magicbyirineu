//
//  AppDelegate.swift
//  magicbyirineu
//
//  Created by daniel.da.cunha.lima on 15/02/19.
//  Copyright © 2019 DanielLima. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Initializing the Root ViewController for working with CodeView
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let rootViewController = MagicTabBarController()
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

