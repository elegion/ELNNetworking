//
//  RequestParameters.swift
//  Networking
//
//  Created by Dmitry Nesterenko on 20.02.16.
//  Copyright © 2016 e-legion. All rights reserved.
//

import Foundation
import Alamofire

/// Struct that allows NSURLRequest construction form HTTP request parameters
public struct RequestParameters : URLRequestConvertible {
    
    let method: Alamofire.Method
    
    let URLString: URLStringConvertible
    
    let parameters: [String: AnyObject]?
    
    let encoding: ParameterEncoding
    
    let headers: [String: String]?
    
    public init(_ method: Alamofire.Method, _ URLString: URLStringConvertible, parameters: [String: AnyObject]? = nil, encoding: ParameterEncoding = .URL, headers: [String: String]? = nil) {
        self.method = method
        self.URLString = URLString
        self.parameters = parameters
        self.encoding = encoding
        self.headers = headers
    }
    
    public var URLRequest: NSMutableURLRequest {
        let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: URLString.URLString)!)
        mutableURLRequest.HTTPMethod = method.rawValue
        
        if let headers = headers {
            for (headerField, headerValue) in headers {
                mutableURLRequest.setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
        
        let encodedURLRequest = encoding.encode(mutableURLRequest, parameters: parameters).0
        
        return encodedURLRequest
    }
    
}