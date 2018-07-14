//
//  ParticipantModel.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/3/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation

protocol ParticipantProtocol: UserDetailProtocol {
    
}

struct ParticipantModel: ParticipantProtocol, Uniq, Decodable, Equatable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case email
        case username
        case fullname
        case company
        case website
        case phone
    }
    
    let id: Int
    let email: String
    let username: String
    let fullname: String
    let company: String
    let website: String
    let phone: String
    
    var identifier: String {
        return "\(id)"
    }
    
}
