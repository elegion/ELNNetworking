//
//  RequestParametersTests.swift
//  Networking
//
//  Created by Dmitry Nesterenko on 20.02.16.
//  Copyright © 2016 e-legion. All rights reserved.
//

import XCTest
import ELNNetworking

class RequestParametersTests: XCTestCase {

    func testRequestParametersHTTPMethod() {
        let request = RequestParameters(.POST, "https://httpbin.org").URLRequest
        XCTAssert(request.HTTPMethod == "POST")
    }

}
