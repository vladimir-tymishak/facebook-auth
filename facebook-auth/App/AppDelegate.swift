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
    
    static var instance: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        SDKApplicationDelegate.shared.application(
            application, didFinishLaunchingWithOptions: launchOptions
        )
        launch(isAuthorized: AccessToken.current != nil)
        return true
    }
    
    func launch(isAuthorized: Bool) {
        window = UIWindow(frame: UIScreen.main.bounds)
        if isAuthorized {
            if let user = UserController.instance.user {
                window?.rootViewController = ProfileViewController(viewModel: ProfileViewModel(with: user))
            } else {
                window?.rootViewController = SignUpViewController(viewModel: SignUpViewModel())
            }
        } else {
            window?.rootViewController = SignUpViewController(viewModel: SignUpViewModel())
        }
        window?.makeKeyAndVisible()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return SDKApplicationDelegate.shared.application(app, open: url, options: options)
    }

}

