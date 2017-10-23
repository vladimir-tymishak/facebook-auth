//
//  SignUpViewController.swift
//  facebook-auth
//
//  Created by Vladimir Tymishak on 22.10.17.
//  Copyright © 2017 own. All rights reserved.
//

import UIKit
import SVProgressHUD

class SignUpViewController: UIViewController {
    // MARK: - Properties
    fileprivate lazy var fbLoginButton: UIButton = {
        var button = UIButton(type: .custom)
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.3529411765, blue: 0.5882352941, alpha: 1)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(onFbLoginButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    fileprivate var viewModel: SignUpViewModel
    
    // MARK: - Init
    init(viewModel: SignUpViewModel) {
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
        view.addSubview(fbLoginButton)
        
        viewModel.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        fbLoginButton.frame = CGRect(
            x: 30,
            y: view.bounds.midY - 35,
            width: view.bounds.width - 60,
            height: 70
        )
    }
    
    // MARK: - Callbacks
    @objc private func onFbLoginButtonPressed(_ sender: UIButton) {
        viewModel.signUp()
    }
    
    // MARK: - Helpers
    fileprivate func showError(with text: String) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - SignUpViewController: SignUpViewModelDelegate -
extension SignUpViewController: SignUpViewModelDelegate {
    func onViewModel(_ viewModel: SignUpViewModel, signedUpWith user: User?, _ error: SignUpError?) {
        guard error == nil else {
            showError(with: error!.text)
            return
        }
        guard let user = user else {
            showError(with: SignUpError.badUser.text)
            return
        }
        UserController.instance.user = user
        AppDelegate.instance.launch(isAuthorized: true)
    }
}
