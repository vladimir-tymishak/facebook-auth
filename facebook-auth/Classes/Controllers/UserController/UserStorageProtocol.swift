//
//  UserStorageProtocol.swift
//  facebook-auth
//
//  Created by Vladimir Tymishak on 23.10.17.
//  Copyright © 2017 own. All rights reserved.
//

import Foundation

protocol UserStorageProtocol {
    
    func save(_ user: User?)
    
    func loadUser() -> User?
}
