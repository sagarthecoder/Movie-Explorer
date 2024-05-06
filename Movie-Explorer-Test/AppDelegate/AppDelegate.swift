//
//  AppDelegate.swift
//  Movie-Explorer-Test
//
//  Created by Sagar on 5/6/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let homeVC = HomeViewController()
        let navController = UINavigationController(rootViewController: homeVC)
        navController.setNavigationBarHidden(true, animated: false)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        return true
    }


}

