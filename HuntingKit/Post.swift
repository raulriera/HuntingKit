//
//  Post.swift
//  HuntingKit
//
//  Created by Raúl Riera on 19/04/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import Foundation

public struct Post: Model {
    public let id: Int
    public let name: String
    public let tagline: String
    public let user: User
    public let featured: Bool
    public let stats: PostStats?
    public let discussionURL: NSURL?
    public let redirectURL: NSURL?
    public let imagesURL: ImagesURL
    public let makerInside: Bool
    public let makers: [User]
    public let votes: [Vote]
    public let comments: [Comment]?
    
    public init?(dictionary: NSDictionary) {
        if let id = dictionary["id"] as? Int,
            let userDictionary = dictionary["user"] as? NSDictionary,
            let user = User(dictionary: userDictionary),
            let imagesURLDictionary = dictionary["screenshot_url"] as? NSDictionary,
            let name = dictionary["name"] as? String,
            let tagline = dictionary["tagline"] as? String,
            let featured = dictionary["featured"] as? Bool,
            let discussionURL = dictionary["discussion_url"] as? String,
            let redirectURL = dictionary["redirect_url"] as? String,
            let makerInside = dictionary["maker_inside"] as? Bool {
                self.id = id
                self.name = name
                self.tagline = tagline
                self.user = user
                self.featured = featured
                self.discussionURL = NSURL(string: discussionURL)
                self.redirectURL = NSURL(string: redirectURL)
                self.stats = PostStats(dictionary: dictionary)
                imagesURL = ImagesURL(dictionary: imagesURLDictionary)
                self.makerInside = makerInside
                
                if let makers = dictionary["makers"] as? [NSDictionary] {
                    self.makers = initEach(makers)
                } else {
                    makers = [User]()
                }
                
                if let votes = dictionary["votes"] as? [NSDictionary] {
                    self.votes = initEach(votes)
                } else {
                    self.votes = [Vote]()
                }
                
                if let comments = dictionary["comments"] as? [NSDictionary] {
                    self.comments = initEach(comments)
                } else {
                    self.comments = .None
                }
                
        } else {
            return nil
        }
    }
}

public struct PostStats {
    public let votes: Int
    public let comments: Int
    
    public init?(dictionary: NSDictionary) {
        if
            let votes = dictionary["votes_count"] as? Int,
            let comments = dictionary["comments_count"] as? Int {
                self.votes = votes
                self.comments = comments
                
        } else {
            return nil
        }
    }
}