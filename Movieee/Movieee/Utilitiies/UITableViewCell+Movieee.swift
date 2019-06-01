//
//  UITableViewCell+Movieee.swift
//  Movieee
//
//  Created by Glenn Von C. Posadas on 01/06/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import UIKit

extension UITableViewCell {
    /// Removes the separator
    func removeSeparator() {
        self.separatorInset = UIEdgeInsets(top: 0, left: 15000, bottom: 0, right: 0)
    }
    
    /// Extend the separator to leading
    func extendSeparatorToLeading() {
        self.separatorInset = .zero
    }
    
    /// Turn off selection of the cell
    func turnOffSelection() {
        self.selectionStyle = .none
    }
}

