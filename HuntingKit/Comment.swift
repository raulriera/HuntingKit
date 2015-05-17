//
//  Comment.swift
//  HuntingKit
//
//  Created by Raúl Riera on 15/05/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import Foundation

public struct Comment: Model {
    
    public let id: Int
    public let body: String
    public let parentCommentId: Int?
    public let user: User
    public let stats: CommentStats?
    public let replies: [Comment]?
    
    public init?(dictionary: NSDictionary) {
        if let id = dictionary["id"] as? Int,
            let userDictionary = dictionary["user"] as? NSDictionary,
            let user = User(dictionary: userDictionary),
            let body = dictionary["body"] as? String {
                self.id = id
                self.body = body
                self.user = user
                self.stats = CommentStats(dictionary: dictionary)
                parentCommentId = dictionary["parent_comment_id"] as? Int
                
                if let replies = dictionary["child_comments"] as? [NSDictionary] {
                    self.replies = initEach(replies)
                } else {
                    replies = .None
                }
                
        } else {
            return nil
        }
    }
    
}

public struct CommentStats {
    public let replies: Int
    
    public init?(dictionary: NSDictionary) {
        if let replies = dictionary["child_comments_count"] as? Int {
            self.replies = replies
        } else {
            return nil
        }
    }
}