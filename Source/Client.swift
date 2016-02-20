//
//  Client.swift
//  Dependencies
//
//  Created by Dmitry Nesterenko on 18.02.16.
//  Copyright © 2016 e-legion. All rights reserved.
//

import Foundation
import Alamofire

public class Client {
    
    public let manager: Manager
    
    public required init(manager: Manager = Manager.sharedInstance) {
        self.manager = manager
    }
    
    public func request<T: Request>(request: T, completionHandler: (Response<T.ResponseType, NSError> -> Void)? = nil) -> Alamofire.Request {
        let URLRequest = request.requestParameters.URLRequest
        return manager.request(URLRequest).response{ (response: Response<T.ResponseType, NSError>) in
            if let completionHandler = completionHandler {
                completionHandler(response)
            }
        }
    }
    
}