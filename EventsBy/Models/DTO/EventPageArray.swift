//
//  EventPageArray.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation

protocol EventPageArrayProtocol {
    
    var content: [EventModel] { get }
    var size: Int { get }
    
}

struct EventPageArray: EventPageArrayProtocol, Uniq, Decodable, Equatable {
    
    private enum CodingKeys: String, CodingKey {
        case content
        case size
    }
    
    let content: [EventModel]
    let size: Int
    
    var identifier: String {
        return "\(0)"
    }
    
}
