//
//  Keychain.swift
//  HuntingKit
//
//  Created by Raúl Riera on 20/04/2015. Modified version of https://gist.github.com/s-aska/e7ad24175fb7b04f78e7
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import Foundation
import UIKit
import Security

class Keychain {
    
    enum KeychainKey: String {
        case Token = "ProductHunt.Keys.Token"
    }
    
    class func save(key: KeychainKey, data: NSData) -> Bool {
        
        let rawKey = key.rawValue
        
        let query = [
            kSecClass as String : kSecClassGenericPassword as String,
            kSecAttrAccount as String : rawKey,
            kSecValueData as String : data ]
        
        SecItemDelete(query as CFDictionaryRef)
        
        let status: OSStatus = SecItemAdd(query as CFDictionaryRef, nil)
        
        return status == noErr
    }
    
    class func load(key: KeychainKey) -> NSData? {
        let rawKey = key.rawValue
        
        let query = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : rawKey,
            kSecReturnData as String : kCFBooleanTrue,
            kSecMatchLimit as String : kSecMatchLimitOne ]
        
        var dataTypeRef :Unmanaged<AnyObject>?
        
        let status: OSStatus = SecItemCopyMatching(query, &dataTypeRef)
        
        if status == noErr {
            return (dataTypeRef!.takeRetainedValue() as? NSData)
        } else {
            return nil
        }
    }
    
    class func delete(key: KeychainKey) -> Bool {
        let rawKey = key.rawValue
        
        let query = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : rawKey ]
        
        let status: OSStatus = SecItemDelete(query as CFDictionaryRef)
        
        return status == noErr
    }
    
    
    class func clear() -> Bool {
        let query = [ kSecClass as String : kSecClassGenericPassword ]
        
        let status: OSStatus = SecItemDelete(query as CFDictionaryRef)
        
        return status == noErr
    }
    
}

extension String {
    internal var dataValue: NSData {
        return dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
    }
}

extension NSData {
    internal var stringValue: String {
        return NSString(data: self, encoding: NSUTF8StringEncoding)! as String
    }
}