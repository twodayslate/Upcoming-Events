//
//  Event.swift
//  events
//
//  Created by Zachary Gorak on 7/16/19.
//  Copyright © 2019 Zachary Gorak. All rights reserved.
//

import Foundation

struct Event: Codable {
    var title: String /// The title of the given event
    var startDate: Date /// The start date and time for the given event
    var endDate: Date /// The end date and time for the given event - for this exercise we assume end is after start
    var conflicts: Bool = false // This event conflicts with another event
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case startDate = "start"
        case endDate = "end"
        
        var stringValue: String {
            return self.rawValue
        }
    }
    
    init?(title: String, startDate: String, endDate: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, y h:m a" // November 3, 2018 6:00 PM https://waracle.com/iphone-nsdateformatter-date-formatting-table/
        self.title = title
        guard let start = dateFormatter.date(from: startDate) else {
            return nil
        }
        self.startDate = start
        guard let end = dateFormatter.date(from: endDate) else {
            return nil
        }
        self.endDate = end
    }
    
    func overlaps(_ event: Event) -> Bool {
        if self.startDate <= event.endDate && event.startDate <= self.endDate {
            // Per spec clarified on 16 JULY
            if self.startDate == self.endDate || event.startDate == event.endDate {
                return true
            }
            // Per spec, if end time is the start time then they don't conflict
            if self.endDate != event.startDate && event.endDate != self.startDate {
                return true
            }
        }
        
        return false
    }
}

extension Event: Comparable {
    // Sorts events by start time
    static func < (lhs: Event, rhs: Event) -> Bool {
        return lhs.startDate < rhs.startDate
    }
}
