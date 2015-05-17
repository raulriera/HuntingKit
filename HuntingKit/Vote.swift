//
//  Vote.swift
//  HuntingKit
//
//  Created by Raúl Riera on 14/05/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import Foundation

public struct Vote: Model {
    
    public let id: Int
    public let user: User
    
    public init?(dictionary: NSDictionary) {
        if let id = dictionary["id"] as? Int,
            let userDictionary = dictionary["user"] as? NSDictionary,
            let user = User(dictionary: userDictionary) {
                self.id = id
                self.user = user
        } else {
            return nil
        }
    }

}