//
//  Date.swift
//  events
//
//  Created by Zachary Gorak on 7/16/19.
//  Copyright © 2019 Zachary Gorak. All rights reserved.
//

import Foundation

extension Date {
    /// This allows for events to be binned by day
    /// - Returns:
    /// `DateComponent` with a month, day, and year
    func binComponents() -> DateComponents {
        return Calendar.current.dateComponents([.month, .day, .year], from: self)
    }
}
