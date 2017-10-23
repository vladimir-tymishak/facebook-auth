//
//  DefaultUserStorage.swift
//  facebook-auth
//
//  Created by Vladimir Tymishak on 23.10.17.
//  Copyright © 2017 own. All rights reserved.
//

import Foundation

extension UserDefaults: UserStorageProtocol {
    private var userDataKey: String {
        return "UserData"
    }
    
    func save(_ user: User?) {
        guard let user = user else {
            return
        }
        guard let userData = try? JSONEncoder().encode(user) else {
            return
        }
        set(userData, forKey: userDataKey)
        synchronize()
    }
    
    func loadUser() -> User? {
        guard let userData = data(forKey: userDataKey) else {
            return nil
        }
        guard let user = try? JSONDecoder().decode(User.self, from: userData) else {
            return nil
        }
        return user
    }
}
