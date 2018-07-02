//
//  DateUtils.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation

final class DateUtils {
    
    static func toDate(timestamp: TimeInterval) -> Date {
        return Date(timeIntervalSince1970: timestamp)
    }
    
    static func toString(date: Date, format: String) -> String {
        let dateFormat = DateFormatters.with(format: format)
        return dateFormat.string(from: date)
    }
    
}
