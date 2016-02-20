//
//  Request.swift
//  Dependencies
//
//  Created by Dmitry Nesterenko on 18.02.16.
//  Copyright © 2016 e-legion. All rights reserved.
//

import Foundation
import Alamofire

/// Protocol to serialize response object into swift models
public protocol ResponseObjectSerializable {
    
    init(response: NSHTTPURLResponse, representation: AnyObject) throws

}

/// Protocol to serialize object to request parameters
public protocol RequestParametersSerializable {
    
    var requestParameters: RequestParameters { get }

}

/// Protocol to describe HTTP requests and associated responses
public protocol Request : RequestParametersSerializable {
    
    typealias ResponseType: ResponseObjectSerializable
    
}

extension Alamofire.Request {
    
    /// Method to send Requests using custom Request object
    public func response<T: ResponseObjectSerializable>(completionHandler: Response<T, NSError> -> Void) -> Self {
        let responseSerializer = ResponseSerializer<T, NSError> { request, response, data, error in
            guard error == nil else {
                return .Failure(error!)
            }
            
            let JSONResponseSerializer = Alamofire.Request.JSONResponseSerializer()
            let result = JSONResponseSerializer.serializeResponse(request, response, data, error)
            
            switch result {
            case .Success(let value):
                if let response = response {
                    do {
                        let responseObject = try T(response: response, representation: value)
                        return .Success(responseObject)
                    } catch let error {
                        return .Failure(error as NSError)
                    }
                } else {
                    let failureReason = "JSON could not be serialized into response object: \(value)"
                    let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                    return .Failure(error)
                }
            case .Failure(let error):
                return .Failure(error)
            }
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }

}
