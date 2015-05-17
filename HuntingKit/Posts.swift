//
//  Posts.swift
//  HuntingKit
//
//  Created by Raúl Riera on 19/04/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import Foundation
import APIKit

extension ProductHunt.Endpoint {
    // https://api.producthunt.com/v1/posts
    public class Posts: APIKit.Request {
        
        public enum Day {
            case Today
            case Yesterday
            case DaysAgo(Int)
            case Custom(NSDate)
        }
        
        public typealias Response = [HuntingKit.Post]
        
        let daysAgo: Int?
        let day: String?
        
        public var URLRequest: NSURLRequest? {
            let parameters: [String : AnyObject]
            
            if let daysAgo = daysAgo {
                parameters = ["days_ago": daysAgo]
            } else if let day = day {
                parameters = ["day": day]
            } else {
                parameters = ["":""]
            }
            
            return ProductHunt.URLRequest(.GET, "/posts", parameters)
        }
        
        public init(from:Day) {
            
            switch from {
            case .Yesterday:
                daysAgo = 1
                day = nil
            case .DaysAgo(let days):
                daysAgo = abs(days)
                day = nil
            case .Custom(let date):
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "YYYY-MM-dd"
                day = dateFormatter.stringFromDate(date)
                daysAgo = nil
            default:
                daysAgo = nil
                day = nil
            }
            
        }
        
        public class func responseFromObject(object: AnyObject) -> Response? {
            var posts: [HuntingKit.Post]?
            
            if let dictionaries = object["posts"] as? [NSDictionary] {
                posts = initEach(dictionaries)
            }
            
            return posts
        }
    }
    
    // https://api.producthunt.com/v1/posts/{id}
    public class Post: APIKit.Request {
        public typealias Response = HuntingKit.Post
        
        let post: HuntingKit.Post
        
        public var URLRequest: NSURLRequest? {
            return ProductHunt.URLRequest(.GET, "/posts/\(post.id)", ["":""])
        }
        
        public init(post: HuntingKit.Post) {
            self.post = post
        }
        
        public class func responseFromObject(object: AnyObject) -> Response? {
            var post: HuntingKit.Post?
            
            if let dictionary = object["post"] as? NSDictionary {
                post = HuntingKit.Post(dictionary:dictionary)
            }
            
            return post
        }
    }
}