//
//  AccessToken.swift
//  HuntingKit
//
//  Created by Raúl Riera on 20/04/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import Foundation

public struct AccessToken {
    
    public let token: String
    public let type: String
    public let expiresIn: Int
    public let scope: String
    
    public init?(dictionary: NSDictionary) {
        if
            let token = dictionary["access_token"] as? String,
            let type = dictionary["token_type"] as? String,
            let expiresIn = dictionary["expires_in"] as? Int,
            let scope = dictionary["scope"] as? String {
                self.token = token
                self.type = type
                self.expiresIn = expiresIn
                self.scope = scope
                
        } else {
            return nil
        }
    }
    
}