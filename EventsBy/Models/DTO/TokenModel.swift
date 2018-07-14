//
//  TokenModel.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/9/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation

protocol TokenProtocol {
    
    var accessToken: String { get }
    var refreshToken: String { get }
    var expiresIn: Int { get }
    
}

struct TokenModel: TokenProtocol, Decodable, Equatable {
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
    }
    
    let accessToken: String
    let refreshToken: String
    let expiresIn: Int
    
}
