//
//  AppDelegate.swift
//  EgnyteTest
//
//  Created by Aadil Majeed on 01/10/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var coordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start()
        self.coordinator = homeCoordinator
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

