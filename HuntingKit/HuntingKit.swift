//
//  HuntingKit.swift
//  HuntingKit
//
//  Created by Raúl Riera on 19/04/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import Foundation
import APIKit
import LlamaKit

public class ProductHunt: API {
    
    static let ProductHuntErrorDomain = "com.raulriera.HuntingKit"

    override public class final var baseURL: NSURL {
        return NSURL(string: "https://api.producthunt.com/v1/")!
    }
    
    override public class final var requestBodyBuilder: RequestBodyBuilder {
        return .JSON(writingOptions: nil)
    }
    
    override public class final var responseBodyParser: ResponseBodyParser {
        return .JSON(readingOptions: nil)
    }
    
    override public class func responseErrorFromObject(object: AnyObject) -> NSError {
        if let error = object as? NSDictionary, let reason = error["error"] as? String, let message = error["error_description"] as? String {
            let userInfo = [NSLocalizedFailureReasonErrorKey: reason, NSLocalizedDescriptionKey: message]
            return NSError(domain: ProductHuntErrorDomain, code: 50000, userInfo: userInfo)
        } else {
            let userInfo = [NSLocalizedFailureReasonErrorKey: "Unknown", NSLocalizedDescriptionKey: "Unknown error occurred."]
            return NSError(domain: ProductHuntErrorDomain, code: 50001, userInfo: userInfo)
        }
    }
        
    override public class func URLRequest(method: APIKit.Method, _ path: String, _ parameters: [String: AnyObject] = [:], requestBodyBuilder: APIKit.RequestBodyBuilder = requestBodyBuilder) -> NSURLRequest? {
        
        let request = super.URLRequest(method, path, parameters)
        
        if let token = Keychain.load(.Token), let request: NSMutableURLRequest = request?.mutableCopy() as? NSMutableURLRequest {
            request.setValue("Bearer \(token.stringValue)", forHTTPHeaderField: "Authorization")
            
            return request.copy() as? NSURLRequest
        } else {
            return request
        }
        
    }
    
    public class Endpoint {
        // Extended in "Endpoints"
    }
}
