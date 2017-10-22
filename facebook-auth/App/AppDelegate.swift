//
//  AppDelegate.swift
//  facebook-auth
//
//  Created by Vladimir Tymishak on 22.10.17.
//  Copyright © 2017 own. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        SDKApplicationDelegate.shared.application(
            application, didFinishLaunchingWithOptions: launchOptions
        )
        launch(AccessToken.current != nil)
        return true
    }
    
    func launch(_ isAuthorized: Bool) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = isAuthorized ? ProfileViewController() : SignUpViewController()
        window?.makeKeyAndVisible()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return SDKApplicationDelegate.shared.application(app, open: url, options: options)
    }

}

