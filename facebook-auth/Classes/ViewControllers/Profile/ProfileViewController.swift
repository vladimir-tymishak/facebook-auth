//
//  ProfileViewController.swift
//  facebook-auth
//
//  Created by Vladimir Tymishak on 22.10.17.
//  Copyright © 2017 own. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    // MARK: - Properties
    fileprivate var viewModel: ProfileViewModel
    
    fileprivate lazy var avatarImageView: UIImageView = {
        var imgView = UIImageView()
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 50
        return imgView
    }()
    
    fileprivate lazy var userIdLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .thin)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate lazy var userNameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate lazy var userEmailLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .thin)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate lazy var logoutButton: UIButton = {
        var button = UIButton(type: .custom)
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(onLogoutButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(avatarImageView)
        view.addSubview(userIdLabel)
        view.addSubview(userNameLabel)
        view.addSubview(userEmailLabel)
        view.addSubview(logoutButton)
        
        viewModel.updateView { (user) in
            avatarImageView.load(from: user.avatarUrl)
            userIdLabel.text = user.id
            userNameLabel.text = user.username
            userEmailLabel.text = user.email
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        avatarImageView.frame = CGRect(
            x: view.bounds.midX - 50,
            y: 30,
            width: 100,
            height: 100
        )
        userIdLabel.frame = CGRect(
            x: 30,
            y: avatarImageView.frame.maxY + 15,
            width: view.bounds.width - 60,
            height: 15
        )
        userNameLabel.frame = CGRect(
            x: 30,
            y: userIdLabel.frame.maxY + 10,
            width: view.bounds.width - 60,
            height: 20
        )
        userEmailLabel.frame = CGRect(
            x: 30,
            y: userNameLabel.frame.maxY + 10,
            width: view.bounds.width - 60,
            height: 15
        )
        logoutButton.frame = CGRect(
            x: 30,
            y: view.bounds.maxY - 100,
            width: view.bounds.width - 60,
            height: 70
        )
    }
    
    // MARK: - Callbacks
    @objc private func onLogoutButtonPressed(_ sender: UIButton) {
        viewModel.logout()
    }
}
