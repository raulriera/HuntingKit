//
//  Static.swift
//  HuntingKit
//
//  Created by Raúl Riera on 18/05/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import Foundation

var formatter: NSDateFormatter {
    struct Static {
        static let instance : NSDateFormatter = {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-ddEEEEEHH:mm:ss.SSSSxxx"
            return formatter
            }()
    }
    
    return Static.instance
}