//
//  EventModel.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation

protocol EventProtocol {
    
    var id: Int { get }
    var name: String { get }
    var description: String { get }
    var start: Date { get }
    var end: Date { get }
    var image: String? { get }
    
}

struct EventModel: EventProtocol, Uniq, Decodable, Equatable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name
        case description
        case _start = "start_date"
        case _end = "end_date"
        case image = "image_url"
    }
    
    let id: Int
    let name: String
    let description: String
    let _start: Double
    let _end: Double
    let image: String?
    
    var start: Date {
        return Date(timeIntervalSince1970: _start)
    }
    
    var end: Date {
        return Date(timeIntervalSince1970: _end)
    }
    
    var identifier: String {
        return "\(id)"
    }
    
}
