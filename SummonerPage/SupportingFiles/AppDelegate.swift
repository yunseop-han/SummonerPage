//
//  AppDelegate.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/02.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = SummonerViewController()
        rootViewController.reactor = SummonerViewReactor()
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        window?.makeKeyAndVisible()
        
        return true
    }
}

