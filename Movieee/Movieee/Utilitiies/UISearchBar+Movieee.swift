//
//  UISearchBar+Movieee.swift
//  Movieee
//
//  Created by Glenn Von C. Posadas on 02/06/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import UIKit

extension UISearchBar {
    /// Checks if the text of the searchBar is empty
    var isEmpty: Bool {
        get {
            return self.text?.isEmpty ?? true
        }
    }
}

extension UISearchController {
    /// Checks if currently the user is using the search.
    var isFiltering: Bool {
        get {
            let searchBarScopeIsFiltering = self.searchBar.selectedScopeButtonIndex != 0
            return self.isActive && (!self.searchBar.isEmpty || searchBarScopeIsFiltering)
        }
    }
}
