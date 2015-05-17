//
//  User.swift
//  HuntingKit
//
//  Created by Raúl Riera on 19/04/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import Foundation

public struct User: Model {
    public let id: Int
    public let name: String
    public let headline: String
    public let username: String
    public let profileURL: NSURL?
    public let imagesURL: ImagesURL
    public let stats: UserStats?
//    public let followers: [User]?
//    public let following: [User]?
//    public let posts: [Post]?
    
    public init?(dictionary: NSDictionary) {
        if
            let id = dictionary["id"] as? Int,
            let username = dictionary["username"] as? String,
            let headline = dictionary["headline"] as? String,
            let profileURLString = dictionary["profile_url"] as? String,
            let imagesURLDictionary = dictionary["image_url"] as? NSDictionary,
            let name = dictionary["name"] as? String {
                self.id = id
                self.name = name
                self.headline = headline
                self.username = username
                if let profileURL = NSURL(string: profileURLString) {
                    self.profileURL = profileURL
                } else {
                    profileURL = .None
                }
                if let stats = UserStats(dictionary: dictionary) {
                    self.stats = stats
                } else {
                    self.stats = .None
                }
                imagesURL = ImagesURL(dictionary: imagesURLDictionary)
        } else {
            return nil
        }
    }
}

public struct UserStats {
    public let votes: Int
    public let posts: Int
    public let made: Int
    public let followers: Int
    public let following: Int
    public let collections: Int
    
    public init?(dictionary: NSDictionary) {
        if
            let votes = dictionary["votes_count"] as? Int,
            let posts = dictionary["posts_count"] as? Int,
            let made = dictionary["maker_of_count"] as? Int,
            let followers = dictionary["followers_count"] as? Int,
            let following = dictionary["followings_count"] as? Int,
            let collections = dictionary["collections_count"] as? Int {
                
                self.votes = votes
                self.posts = posts
                self.made = made
                self.followers = followers
                self.following = following
                self.collections = collections
                
        } else {
            return nil
        }
    }
}