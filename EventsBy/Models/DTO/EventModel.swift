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
    
}

struct EventModel: EventProtocol, Uniq, Decodable, Equatable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name
    }
    
    let id: Int
    let name: String
    
    var identifier: String {
        return "\(id)"
    }
    
}
