//
//  SignUpViewModel.swift
//  facebook-auth
//
//  Created by Vladimir Tymishak on 22.10.17.
//  Copyright © 2017 own. All rights reserved.
//

import Foundation
import FacebookLogin
import FacebookCore

class SignUpViewModel {
    // MARK: - Properties
    weak var delegate: SignUpViewModelDelegate?
    
    fileprivate let loginManager: LoginManager
    
    fileprivate var user: User?
    
    // MARK: - Init
    init() {
        loginManager = LoginManager(loginBehavior: .native, defaultAudience: .everyone)
    }
    
    // MARK: - Public
    func signUp() {
        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: nil) { [weak self] (result) in
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(_, _, _):
                self.loadUserInfo()
            case .failed(let error):
                self.delegate?.onViewModel(self, signedUpWith: nil, SignUpError.failed(reason: error.localizedDescription))
            case .cancelled:
                self.delegate?.onViewModel(self, signedUpWith: nil, SignUpError.cancelled)
            }
        }
    }
    
    func loadUserInfo() {
        if AccessToken.current != nil {
            let request = GraphRequest(graphPath: "/me?fields=id,name,first_name,last_name,email,picture")
            request.start { [weak self] (httpResponse, result) in
                guard let `self` = self else {
                    return
                }
                switch result {
                case .success(let response):
                    guard let info = response.dictionaryValue else {
                        self.delegate?.onViewModel(self, signedUpWith: nil, SignUpError.parsingFailed)
                        return
                    }
                    self.parse(info)
                case .failed(let error):
                    self.delegate?.onViewModel(self, signedUpWith: nil, SignUpError.failed(reason: error.localizedDescription))
                }
            }
        } else {
            signUp()
        }
    }
    
    private func parse(_ info: [String: Any]) {
        let id = info["id"] as? String ?? ""
        let name = info["name"] as? String ?? ""
        let firstName = info["first_name"] as? String ?? ""
        let lastName = info["last_name"] as? String ?? ""
        let email = info["email"] as? String ?? ""
        let picture = pictureUrl(from: info["picture"] as? [String: Any])
        let token = AccessToken.current?.authenticationToken
        
        user = User(id: id, username: name, firstName: firstName, lastName: lastName, avatarUrl: picture, email: email, token: token)
        self.delegate?.onViewModel(self, signedUpWith: user, nil)
    }
    
    private func pictureUrl(from dict: [String: Any]?) -> String? {
        guard
            let dict = dict,
            let data = dict["data"] as? [String: Any],
            let url = data["url"] as? String else {
                return nil
        }
        return url
    }
}

// MARK: - SignUpViewModelDelegate -
protocol SignUpViewModelDelegate: class {
    func onViewModel(_ viewModel: SignUpViewModel, signedUpWith user: User?, _ error: SignUpError?)
}

// MARK: - SignUpError -
enum SignUpError: Error {
    case failed(reason: String)
    
    var text: String {
        switch self {
        case .failed(let reason):
            return reason
        }
    }
    
    static var cancelled: SignUpError {
        return SignUpError.failed(reason: "Sign Up was cancelled by user.")
    }
    
    static var parsingFailed: SignUpError {
        return SignUpError.failed(reason: "Failed to parse user info.")
    }
    
    static var badUser: SignUpError {
        return SignUpError.failed(reason: "User is nil.")
    }
}
