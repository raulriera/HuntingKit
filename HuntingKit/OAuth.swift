//
//  OAuth.swift
//  HuntingKit
//
//  Created by Raúl Riera on 20/04/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import Foundation
import APIKit

extension ProductHunt.Endpoint {
    
    public class ClientToken: APIKit.Request {

        let clientId: String
        let clientSecret: String
        let grantType: String = "client_credentials"
        
        public typealias Response = AccessToken
        
        public var URLRequest: NSURLRequest? {
            let parameters = [
                "client_id": clientId,
                "client_secret": clientSecret,
                "grant_type": "client_credentials"]
            
            return ProductHunt.URLRequest(.POST, "/oauth/token", parameters)
        }
        
        public init(id: String, secret: String) {
            clientId = id
            clientSecret = secret
        }
        
        public class func responseFromObject(object: AnyObject) -> Response? {
            var token: AccessToken?
            
            if let dictionary = object as? NSDictionary {
                if let accessToken = AccessToken(dictionary: dictionary) {
                    Keychain.save(.Token, data: accessToken.token.dataValue)
                    return accessToken
                }
            }
                        
            return token
        }
        
    }
        
}