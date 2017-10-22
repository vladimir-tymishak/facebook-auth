//
//  User.swift
//  facebook-auth
//
//  Created by Vladimir Tymishak on 22.10.17.
//  Copyright © 2017 own. All rights reserved.
//

import Foundation

class User {
    let id: String
    let username: String
    let firstName: String
    let lastName: String
    let avatarUrl: String?
    let email: String
    let token: String?
    
    init(id: String, username: String, firstName: String, lastName: String, avatarUrl: String?, email: String, token: String?) {
        self.id = id
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.avatarUrl = avatarUrl
        self.email = email
        self.token = token
    }
    
    var description: String {
        return """
        User info:
        id = \(id)
        username = \(username)
        firstName = \(firstName)
        lastName = \(lastName)
        avatarUrl = \(avatarUrl ?? "nil")
        email = \(email)
        token = \(token ?? "nil")
        """
    }
}
