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
        let summonerViewController = SummonerViewController()
        summonerViewController.reactor = SummonerViewReactor()
        
        let rootViewController: UINavigationController = .init(rootViewController: summonerViewController)
        rootViewController.setNavigationBarHidden(true, animated: false)
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}

