//
//  AppDelegate.swift
//  Asistencia Bancoppel
//
//  Created by Juan Ramon on 13/02/23.
//

import UIKit
import Firebase


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Firebase Connection
        FirebaseApp.configure()
        
        
        // Override point for customization after application launch.
        //initializeWindow()
        window = UIWindow(frame: UIScreen.main.bounds)
            let viewController = SplashViewController()
            window?.rootViewController = viewController
            window?.makeKeyAndVisible()
        
        return true
    }
    
    /*
    func initializeWindow(){
        let navController: UITabBarController = MainViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        if #available(iOS 13.0, *) {
            window?.backgroundColor = .systemBackground
        }
        window?.rootViewController = navController
    }*/
    
}

