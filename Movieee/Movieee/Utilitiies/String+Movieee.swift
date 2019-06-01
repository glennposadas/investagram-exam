//
//  String+Movieee.swift
//  Movieee
//
//  Created by Glenn Von C. Posadas on 01/06/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Foundation

/// Category for String.
/// Contains String helpers.
extension String {
    
    /// Returns an escaped URL
    var URLEscaped: URL? {
        return URL(string: self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
    
}

