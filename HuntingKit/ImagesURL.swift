//
//  ImagesURL.swift
//  HuntingKit
//
//  Created by Raúl Riera on 24/04/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

public struct ImagesURL {
    public enum Size: String {
        case Original = "original"
        case Size32 = "32px"
        case Size40 = "40px"
        case Size44 = "44px"
        case Size48 = "48px"
        case Size50 = "50px"
        case Size60 = "60px"
        case Size64 = "64px"
        case Size73 = "73px"
        case Size80 = "80px"
        case Size88 = "88px"
        case Size96 = "96px"
        case Size100 = "100px"
        case Size110 = "110px"
        case Size120 = "120px"
        case Size132 = "132px"
        case Size146 = "146px"
        case Size160 = "160px"
        case Size176 = "176px"
        case Size220 = "220px"
        case Size264 = "264px"
        case Size300 = "300px"
        case Size850 = "850px"
        
        case Retina32 = "32px@2X"
        case Retina40 = "40px@2X"
        case Retina44 = "44px@2X"
        case Retina88 = "48px@2X"
        
        case RetinaHD32 = "32px@3X"
        case RetinaHD40 = "40px@3X"
        case RetinaHD44 = "44px@3X"
        case RetinaHD88 = "48px@3X"
    }
    
    let images: NSDictionary
    /// All available sizes
    public var sizes: [Size] {
        var keys = [Size]()
        for key in images.allKeys {
            if let key = key as? String, let size = Size(rawValue: key) {
                keys.append(size)
            }
        }
        
        return keys
    }
    
    public init(dictionary: NSDictionary) {
        images = dictionary
    }
    
    public subscript(key: Size) -> NSURL? {
        get {
            if let imageURL = images[key.rawValue] as? String {
                return NSURL(string: imageURL)
            } else {
                return .None
            }
        }
    }
}
