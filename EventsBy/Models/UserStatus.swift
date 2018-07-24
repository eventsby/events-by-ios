//
//  UserStatus.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/8/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation

enum UserStatus {
    
    case anonymous
    case registered(UserDetailProtocol)
    
    var isAnonymous: Bool {
        switch self {
        case .anonymous:
            return true
        case .registered:
            return false
        }
    }
    
}
