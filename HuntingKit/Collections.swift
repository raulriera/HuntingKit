//
//  Collections.swift
//  HuntingKit
//
//  Created by Raúl Riera on 03/05/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import Foundation
import APIKit

extension ProductHunt.Endpoint {
    // https://api.producthunt.com/v1/collections
    public class Collections: APIKit.Request {
        
        public typealias Response = [HuntingKit.Collection]
        
        let featured: Bool
        
        public var URLRequest: NSURLRequest? {
            let parameters: [String : AnyObject]
            
            if featured {
                parameters = ["search[featured]": featured]
            } else {
                parameters = ["":""]
            }
            
            return ProductHunt.URLRequest(.GET, "collections", parameters)
        }
        
        public init(featured: Bool = false) {
            self.featured = featured
        }
        
        public class func responseFromObject(object: AnyObject) -> Response? {
            var collections: [HuntingKit.Collection]?
            
            if let dictionaries = object["collections"] as? [NSDictionary] {
                collections = initEach(dictionaries)
            }
            
            return collections
        }
    }
    
    // https://api.producthunt.com/v1/collections/{id}
    public class Collection: APIKit.Request {
        
        public typealias Response = HuntingKit.Collection
        
        let collection: HuntingKit.Collection
        
        public var URLRequest: NSURLRequest? {
            return ProductHunt.URLRequest(.GET, "collections/\(collection.id)", ["":""])
        }
        
        public init(collection: HuntingKit.Collection) {
            self.collection = collection
        }
        
        public class func responseFromObject(object: AnyObject) -> Response? {
            var collection: HuntingKit.Collection?
            
            if let dictionary = object["collection"] as? NSDictionary {
                if let collection = HuntingKit.Collection(dictionary: dictionary) {
                    return collection
                }
            }
            
            return collection
        }
    }
    
}