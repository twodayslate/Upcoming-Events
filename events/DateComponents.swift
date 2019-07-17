//
//  DateComponents.swift
//  events
//
//  Created by Zachary Gorak on 7/16/19.
//  Copyright © 2019 Zachary Gorak. All rights reserved.
//

import Foundation

extension DateComponents: Comparable {
    // allows binning by day
    public static func < (lhs: DateComponents, rhs: DateComponents) -> Bool {
        if let ld = lhs.date, let rd = rhs.date {
            return ld < rd
        }
        if let ld = Calendar.current.date(from: lhs), let rd = Calendar.current.date(from: rhs) {
            return ld < rd
        }
        if let ly = lhs.year, let ry = rhs.year {
            if ly < ry { return true }
            if ly > ry { return false }
        }
        if let lm = lhs.month, let rm = rhs.month {
            if lm < rm { return true }
            if lm > rm { return false }
        }
        if let ld = lhs.day, let rd = rhs.day {
            if ld < rd { return true }
            if ld > rd { return false }
        }
        // XXX: do more finetune comparison... but this fits our needs
        return false
    }
}
