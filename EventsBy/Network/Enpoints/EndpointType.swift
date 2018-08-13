//
//  EndpointType.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 8/13/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation
import Alamofire

protocol EndpointType {
    var url: String { get }
    var method: HTTPMethod { get }
    var params: [String: Any]? { get }
}

struct EndpointEntity: EndpointType {
    
    let url: String
    let method: HTTPMethod
    let params: [String : Any]?
    
}
