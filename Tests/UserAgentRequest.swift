//
//  UserAgentRequest.swift
//  Networking
//
//  Created by Dmitry Nesterenko on 20.02.16.
//  Copyright © 2016 e-legion. All rights reserved.
//

import Foundation
import ELNNetworking

struct UserAgentResponse : ResponseObjectSerializable {
    
    var userAgent: String?
    
    init(response: NSHTTPURLResponse, representation: AnyObject) throws {
        userAgent = representation.valueForKey("user-agent") as? String
    }
    
}

struct UserAgentRequest : Request {
    
    typealias ResponseType = UserAgentResponse
    
    var requestParameters: RequestParameters {
        return RequestParameters(.GET, "https://httpbin.org/user-agent")
    }
    
}