//
//  LoginViewController.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 25/7/2564 BE.
//

import UIKit
import LineSDK



class LoginViewController: UIViewController {
        
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login with LINE", for: .normal)
        button.backgroundColor = .systemGreen
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        loginButton.frame = CGRect(x: 15, y: view.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 50, width: view.width - 30, height: 40)
    }
    
    
    @objc private func didTapLogin() {
        LoginManager.shared.login(permissions: [.profile, .openID], in: self) { (result) in
            switch result {
            case .success(let loginResult):
                // Cache token
                let accessToken = loginResult.accessToken.value
                let expirationDate = loginResult.accessToken.expiresAt
                AuthManager.shared.cacheToken(accessToken: accessToken, expirationDate: expirationDate)
                // Redirect user to Home
                UIApplication.shared.windows.first?.rootViewController = TabBarViewController()
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    
}

