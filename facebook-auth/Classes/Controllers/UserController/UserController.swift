//
//  UserController.swift
//  facebook-auth
//
//  Created by Vladimir Tymishak on 23.10.17.
//  Copyright © 2017 own. All rights reserved.
//

import Foundation

class UserController {
    // MARK: - Properties
    static let instance = UserController()
    
    fileprivate let storage: UserStorageProtocol
    
    var user: User? {
        get {
            return storage.loadUser()
        }
        set {
            storage.save(newValue)
        }
    }
    
    // MARK: - Init
    init(with storage: UserStorageProtocol = UserDefaults.standard) {
        self.storage = storage
    }
}
