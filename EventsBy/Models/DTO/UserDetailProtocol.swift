//
//  UserDetailProtocol.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/9/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation

protocol UserDetailProtocol {
    
    var id: Int { get }
    var email: String { get }
    var username: String { get }
    var fullname: String { get }
    var company: String { get }
    var website: String { get }
    var phone: String { get }
    
}

struct UserDetail: UserDetailProtocol, Codable {
    
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
    
    init(id: Int, email: String, username: String, fullname: String, company: String, website: String, phone: String) {
        self.id = id
        self.email = email
        self.username = username
        self.fullname = fullname
        self.company = company
        self.website = website
        self.phone = phone
    }
    
    init(_ user: UserDetailProtocol) {
        self.init(id: user.id, email: user.email, username: user.username, fullname: user.fullname, company: user.company, website: user.website, phone: user.phone)
    }
    
}
