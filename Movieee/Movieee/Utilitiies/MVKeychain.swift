//
//  MVKeychain.swift
//  Movieee
//
//  Created by Glenn Von C. Posadas on 02/06/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Foundation

public enum KeychainKey: String {
    case username = "keychainUsername"
    case password = "keychainPassword"
}

// Arguments for the keychain queries
private let kSecClassValue = NSString(format: kSecClass)
private let kSecAttrAccountValue = NSString(format: kSecAttrAccount)
private let kSecValueDataValue = NSString(format: kSecValueData)
private let kSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword)
private let kSecAttrServiceValue = NSString(format: kSecAttrService)
private let kSecMatchLimitValue = NSString(format: kSecMatchLimit)
private let kSecReturnDataValue = NSString(format: kSecReturnData)
private let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne)

open class MVKeychain {
    /**
     * Internal methods for querying the keychain.
     */
    
    private class func getKeychainQuery(service: KeychainKey, country: String = "PH") -> NSMutableDictionary {
        let serviceStr = service.rawValue + country
        return NSMutableDictionary(dictionary: [kSecClass: kSecClassGenericPassword, kSecAttrService: serviceStr, kSecAttrAccount: serviceStr, kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock])
    }
    
    open class func save(service: KeychainKey, data: Any, country: String = "PH") {
        // Instantiate a new default keychain query
        let keychainQuery: NSMutableDictionary = getKeychainQuery(service: service, country: country)
        
        // Delete any existing items
        SecItemDelete(keychainQuery as CFDictionary)
        
        keychainQuery.setObject(NSKeyedArchiver.archivedData(withRootObject: data), forKey: kSecValueData as! NSCopying)
        
        // Add the new keychain item
        SecItemAdd(keychainQuery as CFDictionary, nil)
    }
    
    open class func delete(service: KeychainKey, country: String = "PH") {
        // Instantiate a new default keychain query
        let keychainQuery: NSMutableDictionary = getKeychainQuery(service: service, country: country)
        
        // Delete any existing items
        SecItemDelete(keychainQuery as CFDictionary)
    }
    
    open class func deleteAllData() {
        let secItemClasses = [kSecClassGenericPassword,
                              kSecClassInternetPassword,
                              kSecClassCertificate,
                              kSecClassKey,
                              kSecClassIdentity]
        for secItemClass in secItemClasses {
            let dictionary = [kSecClass as String: secItemClass]
            SecItemDelete(dictionary as CFDictionary)
        }
    }
    
    open class func load(service: KeychainKey, country: String = "PH") -> Any? {
        let keychainQuery: NSMutableDictionary = getKeychainQuery(service: service, country: country)
        keychainQuery.setObject(kCFBooleanTrue as Any, forKey: kSecReturnData as! NSCopying)
        keychainQuery.setObject(kSecMatchLimitOne, forKey: kSecMatchLimit as! NSCopying)
        
        var keyData: AnyObject?
        var contentsOfKeychain: Any? = nil
        
        if SecItemCopyMatching(keychainQuery, &keyData) == noErr {
            if let retrievedData = keyData as? NSData {
                contentsOfKeychain = NSKeyedUnarchiver.unarchiveObject(with: retrievedData as Data)
            }
        }
        
        return contentsOfKeychain
    }
}

