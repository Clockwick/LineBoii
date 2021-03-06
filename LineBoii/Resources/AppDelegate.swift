//
//  AppDelegate.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 25/7/2564 BE.
//

import UIKit
import LineSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        if let channelID = Bundle.main.infoDictionary?["ChannelID"] as? String,
           let _ = Int(channelID)
        {
            LoginManager.shared.setup(channelID: channelID, universalLinkURL: nil)
            UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
            if AuthManager.shared.isSignedIn {
                print("Sign in")
                
                AuthManager.shared.refreshIfNeeded(completion: nil)
                
                window.rootViewController = TabBarViewController()
            }
            else {
                print("Not Logged in")
                let navVC = UINavigationController(rootViewController: LoginViewController())
                navVC.navigationBar.prefersLargeTitles = true
                navVC.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
                window.rootViewController = navVC
            }
            
        } else {
            fatalError("Please set correct channel ID in Config.xcconfig file.")
        }
        return true
    }
}

