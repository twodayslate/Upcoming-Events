//
//  eventsTests.swift
//  eventsTests
//
//  Created by Zachary Gorak on 7/16/19.
//  Copyright © 2019 Zachary Gorak. All rights reserved.
//

import XCTest
@testable import events

class eventsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEventCreation() {
        let data = [
            [
                "title": "A big party",
                "start": "November 3, 2018 6:00 PM",
                "end": "November 3, 2018 10:00 PM"
            ],
            [
                "title": "A small party",
                "start": "November 3, 2018 6:00 PM",
                "end": "November 7, 2018 6:00 PM"
            ]
        ]
        
        for d in data {
            XCTAssertNotNil(Event(title: d["title"]!, startDate: d["start"]!, endDate: d["end"]!))
        }
        
        let badData = [
            [
                "title": "A big party",
                "start": "November XX, 2018 6:00 PM",
                "end": "November 3, 2018 10:00 PM"
            ],
            [
                "title": "A small party",
                "start": "November 3, 2018 6:00 PM",
                "end": "November 7, 2018 6:00 ??"
            ]
        ]
        
        for d in badData {
            XCTAssertNil(Event(title: d["title"]!, startDate: d["start"]!, endDate: d["end"]!))
        }
    }
    
    func testEventOverlap() {
        let one = Event(title: "One", startDate: "November 3, 2018 6:00 PM", endDate: "November 3, 2018 10:00 PM")!
        XCTAssertTrue(one.overlaps(one))
        
        let two = Event(title: "Two", startDate: "November 3, 2018 6:00 PM", endDate: "November 3, 2018 8:00 PM")!
        XCTAssertTrue(two.overlaps(two))
        
        XCTAssertTrue(one.overlaps(two))
        XCTAssertTrue(two.overlaps(one))
        
        let three = Event(title: "Two", startDate: "November 3, 2018 6:00 PM", endDate: "November 3, 2018 6:01 PM")!
        XCTAssertTrue(three.overlaps(three))
        
        XCTAssertTrue(one.overlaps(three))
        XCTAssertTrue(three.overlaps(one))
        XCTAssertTrue(two.overlaps(three))
        XCTAssertTrue(three.overlaps(two))
        
        let four = Event(title: "Two", startDate: "November 3, 2018 10:00 PM", endDate: "November 3, 2018 10:30 PM")!
        XCTAssertTrue(four.overlaps(four))
        
        XCTAssertFalse(one.overlaps(four))
        XCTAssertFalse(four.overlaps(one))
        XCTAssertFalse(two.overlaps(four))
        XCTAssertFalse(four.overlaps(two))
        XCTAssertFalse(three.overlaps(four))
        XCTAssertFalse(four.overlaps(three))
        
        let five = Event(title: "Two", startDate: "November 4, 2018 10:00 PM", endDate: "November 4, 2018 10:30 PM")!
        XCTAssertTrue(five.overlaps(five))
        
        XCTAssertFalse(one.overlaps(five))
        XCTAssertFalse(two.overlaps(five))
        XCTAssertFalse(three.overlaps(five))
        XCTAssertFalse(four.overlaps(five))
        XCTAssertFalse(five.overlaps(one))
        XCTAssertFalse(five.overlaps(two))
        XCTAssertFalse(five.overlaps(three))
        XCTAssertFalse(five.overlaps(four))
        
        let same = Event(title: "One", startDate: "November 3, 2018 6:00 PM", endDate: "November 3, 2018 6:00 PM")!
        XCTAssertTrue(same.overlaps(same))
        XCTAssertTrue(same.overlaps(one))
        XCTAssertTrue(one.overlaps(same))
        XCTAssertFalse(same.overlaps(four))
        XCTAssertFalse(four.overlaps(same))
    }
}
