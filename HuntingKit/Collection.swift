//
//  Collection.swift
//  HuntingKit
//
//  Created by Raúl Riera on 03/05/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import Foundation

public struct Collection: Model {
    public let id: Int
    public let name: String
    public let title: String
    public let user: User
    public let stats: CollectionStats?
    public let discussionURL: NSURL?
    public let imageURL: NSURL?
    public let posts: [Post]
    
    public init?(dictionary: NSDictionary) {
        if let id = dictionary["id"] as? Int,
            let userDictionary = dictionary["user"] as? NSDictionary,
            let user = User(dictionary: userDictionary),
            let name = dictionary["name"] as? String,
            let title = dictionary["title"] as? String,
            let discussionURL = dictionary["collection_url"] as? String,
            let imageURL = dictionary["background_image_url"] as? String {
                self.id = id
                self.name = name
                self.title = title
                self.user = user
                self.discussionURL = NSURL(string: discussionURL)
                self.imageURL = NSURL(string: imageURL)
                self.stats = CollectionStats(dictionary: dictionary)
                
                if let posts = dictionary["posts"] as? [NSDictionary] {
                    self.posts = initEach(posts)
                } else {
                    posts = [Post]()
                }

        } else {
            return nil
        }
    }
}

public struct CollectionStats {
    public let posts: Int
    
    public init?(dictionary: NSDictionary) {
        if
            let posts = dictionary["posts_count"] as? Int {
                self.posts = posts
                
        } else {
            return nil
        }
    }
}
