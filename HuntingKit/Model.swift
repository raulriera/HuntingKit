//
//  Model.swift
//  HuntingKit
//
//  Created by Raúl Riera on 30/04/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import Foundation

protocol Model {
    init?(dictionary: NSDictionary)
}

func initEach<T: Model>(dictionaries: [NSDictionary]) -> [T] {
    var array = [T]()
    for dictionary in dictionaries {
        if let object = T(dictionary: dictionary) {
            array.append(object)
        }
    }
    
    return array
}