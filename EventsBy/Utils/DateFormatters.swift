//
//  DateFormatters.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation

final class DateFormatters {
    
    private static var cache: [String: DateFormatter] = [:]
    
    static func with(format: String) -> DateFormatter {
        if let formatter = cache[format] {
            return formatter
        }
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        cache[format] = formatter
        
        return formatter
    }
    
}
