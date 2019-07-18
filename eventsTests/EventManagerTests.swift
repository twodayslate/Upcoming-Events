//
//  EventManagerTests.swift
//  eventsTests
//
//  Created by Zachary Gorak on 7/18/19.
//  Copyright © 2019 Zachary Gorak. All rights reserved.
//

import Foundation
import XCTest
@testable import events

class EventManagerTests: XCTestCase {
    func testManagerJsonResourceCreation() {
        let mock = EventManager(withJsonResourceName: "mock")
        XCTAssertNotNil(mock)
        XCTAssertFalse(mock!.allEvents.isEmpty)
        
        let invalid = EventManager(withJsonResourceName: "does not exist")
        XCTAssertNil(invalid)
    }
    
    func testJsonStringCreation() {
        let empty = EventManager(with: "[]")
        XCTAssertNotNil(empty)
        XCTAssertTrue(empty!.allEvents.isEmpty)
        
        let one = EventManager(with: """
[{"title": "Evening Picnic", "start": "November 10, 2018 6:00 PM", "end": "November 10, 2018 7:00 PM"}]
""")
        XCTAssertNotNil(one)
        XCTAssertFalse(one!.allEvents.isEmpty)
        XCTAssertEqual(one!.allEvents.count, 1)
    }
}
