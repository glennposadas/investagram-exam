//
//  RootViewController.swift
//  Movieee
//
//  Created by Glenn Von C. Posadas on 02/06/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - Functions
    // MARK: Overrides
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // No request token, proceeed to auth flow.
        if MVDefaults.getObjectWithKey(.requestToken, type: String.self) == nil {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                let loginNavigationController = storyboard_Auth.instantiateViewController(withIdentifier: "LoginNavigationController") as! UINavigationController
                
                UIView.transition(with: appDelegate.window!, duration: 0.1, options: [], animations: {
                    appDelegate.window?.rootViewController = loginNavigationController
                }, completion: nil)
            }
            return
        }
        
        // There's a saved request token, validate it.
        
        guard let keychainUsername = MVKeychain.load(service: .username) as? String,
            let keychainPassword = MVKeychain.load(service: .password) as? String else { return }
        
        APIManager.AuthCalls.login(
            username: keychainUsername,
            password: keychainPassword,
            onSuccess: { (tokenResult) in
                MVDefaults.store(tokenResult?.requestToken ?? "", key: .requestToken)
                
                if let _ = tokenResult {
                    // Success
                    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                        let homeNavigationController = storyboard_Home.instantiateViewController(withIdentifier: "HomeNavigationController") as! UINavigationController
                        
                        UIView.transition(with: appDelegate.window!, duration: 0.1, options: [], animations: {
                            appDelegate.window?.rootViewController = homeNavigationController
                        }, completion: nil)
                    }
                }
                
        }) { (errorMessage, _, _) in
            self.alert(title: "Movieee", message: errorMessage, okayButtonTitle: "OK")
        }
    }
    
}