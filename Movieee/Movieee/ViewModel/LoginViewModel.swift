//
//  LoginViewModel.swift
//  Movieee
//
//  Created by Glenn Von C. Posadas on 02/06/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Foundation
import Moya
import RxCocoa
import RxSwift

/// The delegate of the ```LoginViewModel```
protocol LoginDelegate: class {
    /// Presents the alert with third button option
    func presentAlert(title: String, message: String, firstButtonTitle: String)
}

class LoginViewModel: NSObject {
    
    // MARK: - Properties
    
    weak var delegate: LoginDelegate?
    
    // Inputs
    var email = BehaviorRelay<String>(value: "")
    var password = BehaviorRelay<String>(value: "")
    
    // MARK: Functions
    
    /// init
    init(loginController: LoginDelegate) {
        super.init()
        
        self.delegate = loginController
    }
    
    // MARK: Button Events
    
    /// Selector for login button
    func login() {
        if self.email.value.isEmpty || self.password.value.isEmpty { return }
        APIManager.AuthCalls.newRequestToken(onSuccess: { (tokenResult) in
            MVDefaults.store(tokenResult?.requestToken ?? "", key: .requestToken)
            MVKeychain.save(service: .username, data: self.email.value)
            MVKeychain.save(service: .password, data: self.password.value)
            self.validateRequestToken()
            
        }) { (errorMessage, _, _) in
            self.delegate?.presentAlert(title: "Movieee", message: errorMessage, firstButtonTitle: "OK")
        }
    }
    
    /// The login method, used for validation of the request token.
    func validateRequestToken() {
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
            self.delegate?.presentAlert(title: "Movieee", message: errorMessage, firstButtonTitle: "OK")
        }
    }
}

