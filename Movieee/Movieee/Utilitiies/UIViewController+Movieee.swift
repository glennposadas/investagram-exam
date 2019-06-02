//
//  UIViewController+Movieee.swift
//  Movieee
//
//  Created by Glenn Von C. Posadas on 02/06/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import UIKit

extension UIViewController {
    /**
     Presents an alertController with completion.
     - parameter title: The title of the alert.
     - parameter message: The body of the alert, nullable, since we can just sometimes use the title parameter.
     - parameter okButtonTitle: the title of the okay button.
     */
    public func alert(
        title: String,
        message: String? = nil,
        okayButtonTitle: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: okayButtonTitle, style: .default) { _ in
           // future completion block here...
        }
        alertController.addAction(okAction)
        
        alertController.view.tintColor = .black
        present(alertController, animated: true, completion: nil)
    }
}
