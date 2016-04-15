//
//  Tests.swift
//  Tests
//
//  Created by Dmitry Nesterenko on 20.02.16.
//  Copyright © 2016 e-legion. All rights reserved.
//

import XCTest
import ELNNetworking

class Tests: XCTestCase {
    
    var client: Client!
    
    override func setUp() {
        super.setUp()
        client = Client()
    }
    
    func testClientFiresResponseCallback() {
        let expectation = expectationWithDescription("example")
        client.request(UserAgentRequest()) { response in
            XCTAssert(true)
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(client.manager.session.configuration.timeoutIntervalForRequest, handler: nil)
    }

    func testClientReturnsSerializedResponseObject() {
        let expectation = expectationWithDescription("example")
        client.request(UserAgentRequest()) { response in
            XCTAssertNotNil(response.result.value?.userAgent)
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(client.manager.session.configuration.timeoutIntervalForRequest, handler: nil)
    }
    
}
