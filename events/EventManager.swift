//
//  Events.swift
//  events
//
//  Created by Zachary Gorak on 7/16/19.
//  Copyright © 2019 Zachary Gorak. All rights reserved.
//

import Foundation

final class EventManager {
    /**
     Events are binned by day with the `DateComponents` generated from each
     event's `startDate.components()`
     Used a dictionary for quicker future lookups of events that start on a given date
     I could have done the date seperation lookup by doing some array filter function
     but this is much faster in the long run O(1) for day lookups instead of O(n)
     */
    var events = [DateComponents: [Event]]() {
        didSet {
            // reset the cache every time events chagnes
            _cachedSortedKeys = nil
        }
    }
    
    /**
     All the events
     - Complexity:
     O(m + n), where n is the length of this sequence and m is the length of the result.
     */
    var allEvents: [Event] {
        return self.events.flatMap{ $0.value }
    }
    
    private var _cachedSortedKeys: [DateComponents]? = nil
    /**
     Sort the keys by start date
     This is necessary to properly handle conflicts in a performant manner
     - Complexity:
     O(n log n), where n is the length of the sequence.
     */
    var sortedKeys: [DateComponents] {
        if let cache = _cachedSortedKeys {
            return cache
        }
        _cachedSortedKeys = Array(events.keys).sorted(by: <)
        return _cachedSortedKeys!
    }
    
    // MARK: - Initializers
    
    init(with events: [[String: Any]]) {
        // O(n)
        for event in events {
            if let start = event[Event.CodingKeys.startDate.stringValue] as? String, let title = event[Event.CodingKeys.title.stringValue] as? String, let end = event[Event.CodingKeys.endDate.stringValue] as? String, let producedEvent = Event(title: title, startDate: start, endDate: end) {
                self.add(producedEvent)
            }
        }
        
        self.markConflicts()
    }
    
    init(with events: [Event]) {
        // O(n)
        for event in events {
            self.add(event)
        }
        
        self.markConflicts()
    }
    
    convenience init?(with json: String) {
        guard let jsonData = json.data(using: .utf8) else {
            return nil
        }
        
        guard let jsonResult = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]] else {
            return nil
        }
        
        self.init(with: jsonResult)
    }
    
    convenience init?(withJsonResourceName name: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else {
            return nil
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            return nil
        }
        guard let jsonResult = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {
            return nil
        }
        
        self.init(with: jsonResult)
    }
    
    // MARK: - Events
    
    /**
     Adds an event to `events` ensure it is in the correct day bin
     - Note:
     This does not ensure the event is sorted or marked as a conflict
     */
    func add(_ event: Event) {
        let comps = event.startDate.binComponents()
        if let _ = self.events[comps] {
            self.events[comps]?.append(event)
        } else {
            self.events[comps] = [event]
        }
    }
    
    /**
     Set and return the events sorted for a given key
     - Complexity:
     O(n log n), where n is the length of the sequence
     */
    func sortedEvents(for key: DateComponents) -> [Event]? {
        guard let dayEvents = self.events[key] else { return nil }
        self.events[key] = dayEvents.sorted(by: <)
        return self.events[key]
    }
    
    // MARK: - Conflicts
    
    /**
     Marks the conflicts for every bin
     - Complexity:
     O(m n log n), where n is the number of values in the sequence, m is the number of different days
     */
    func markConflicts() {
        // O(m)
        for bin in self.events {
            // O(n log n)
            self.markConflicts(for: bin.key)
        }
    }
    
    /**
     Sorts the events for `key` and marks each event for conflicts
     - Complexity:
     O(n log n), where n is the number of values in the sequence
     */
    func markConflicts(for key: DateComponents) {
        // O(n log n)
        guard let dayEvents = self.sortedEvents(for: key) else { return }
        
        var lastEndDateEvent: (Event, Int)? = nil
        // O(n)
        for (i, _) in dayEvents.enumerated() {
            // O(1) - check the latest end date and see if there is a conflict
            if let (checkEvent, checkIndex) = lastEndDateEvent {
                if self.events[key]![i].startDate < checkEvent.endDate {
                    self.events[key]![i].conflicts = true
                    self.events[key]![checkIndex].conflicts = true
                } else {
                    lastEndDateEvent = (self.events[key]![i], i)
                }
            } else {
                lastEndDateEvent = (self.events[key]![i], i)
            }
        }
    }
}
