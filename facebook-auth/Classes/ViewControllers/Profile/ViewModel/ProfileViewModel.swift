//
//  ProfileViewModel.swift
//  facebook-auth
//
//  Created by Vladimir Tymishak on 23.10.17.
//  Copyright © 2017 own. All rights reserved.
//

import Foundation
import FacebookLogin

class ProfileViewModel {
    // MARK: - Properties
    fileprivate var user: User?
    
    // MARK: - Init
    init(with user: User) {
        self.user = user
    }
    
    // MARK: - Public
    func updateView(_ callback: (User) -> Void) {
        guard let user = user else {
            return
        }
        callback(user)
    }
    
    func logout() {
        let loginManager = LoginManager()
        loginManager.logOut()
        UserController.instance.user = nil
        AppDelegate.instance.launch(isAuthorized: false)
    }
}
