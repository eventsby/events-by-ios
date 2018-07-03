//
//  ParticipantModel.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/3/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation

protocol ParticipantProtocol {
    
    var id: Int { get }
    var email: String { get }
    var username: String { get }
    var fullname: String { get }
    var company: String { get }
    var website: String { get }
    var phone: String { get }
    
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
