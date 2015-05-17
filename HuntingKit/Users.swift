//
//  Users.swift
//  HuntingKit
//
//  Created by Raúl Riera on 19/04/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import Foundation
import APIKit

extension ProductHunt.Endpoint {
    // https://api.producthunt.com/v1/users/{id}
    public class User: APIKit.Request {
        
        public typealias Response = HuntingKit.User
        
        let user: HuntingKit.User
        
        public var URLRequest: NSURLRequest? {
            let parameters = ["":""]
            return ProductHunt.URLRequest(.GET, "/users/\(user.username)", parameters)
        }
        
        public init(user:HuntingKit.User) {
            self.user = user
        }
        
        public class func responseFromObject(object: AnyObject) -> Response? {
            var user: HuntingKit.User?
            
            if let dictionary = object["user"] as? NSDictionary {
                if let user = HuntingKit.User(dictionary: dictionary) {
                    return user
                }
            }
            return user
        }
    }
    
}