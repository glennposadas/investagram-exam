//
//  MVDefaults.swift
//  Movieee
//
//  Created by Glenn Von C. Posadas on 02/06/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Foundation

enum MVDefaultsKey: String {
    case requestToken = "defaultsRequestToken"
    case someOtherKey = "defaultsKeyForTests"
}

/// The class that has multiple class functions for handling defaults.
/// Also has the helper class functions for handling auth tokens.
class MVDefaults {
    
    // MARK: - Functions
    
    /// Stores object.
    class func store<T: Encodable>(_ object: T, key: MVDefaultsKey) {
        let encoder = JSONEncoder()
        let encoded = try? encoder.encode(object)
        
        if encoded == nil {
            UserDefaults.standard.set(object, forKey: key.rawValue)
            return
        }
        
        UserDefaults.standard.set(encoded, forKey: key.rawValue)
    }
    
    /// Removes the object token
    class func removeDefaultsWithKey(_ key: MVDefaultsKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    /// Returns stored object (optional) if any.
    class func getObjectWithKey<T: Decodable>(_ key: MVDefaultsKey, type: T.Type) -> T? {
        if let savedData = UserDefaults.standard.data(forKey: key.rawValue) {
            let object = try? JSONDecoder().decode(type, from: savedData)
            return object
        }
        
        return UserDefaults.standard.object(forKey: key.rawValue) as? T
    }
}


