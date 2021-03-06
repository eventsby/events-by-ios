//
//  Endpoints.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation

struct API {
    static let version = "v1"
    static let baseUrl = "https://eventsby.herokuapp.com/api/" + version + "/"
}

protocol Endpoint {
    var path: String { get }
    var url: String { get }
    // TODO method, params
}

enum Endpoints {
    
    enum Events: Endpoint {
        case fetch
        
        public var path: String {
            switch self {
            case .fetch: return "events"
            }
        }
        
        public var url: String {
            switch self {
            case .fetch: return "\(API.baseUrl)\(path)"
            }
        }
    }
}
