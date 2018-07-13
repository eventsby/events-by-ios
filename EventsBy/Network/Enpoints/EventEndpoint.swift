//
//  EventEndpoint.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/11/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation
import Alamofire

enum EventEndpoint: BaseEndPoint {
    
    case events(page: Int, limit: Int)
    
    func requestDetails() -> (url: String, method: HTTPMethod, parameters: [String : Any]?) {
        switch self {
        case .events(let page, let limit):
            var url = "\(NetworkConstants.baseUrl)\(NetworkConstants.version)"
            url.append("events?page=\(page)&size=\(limit)")
            return (url: url, method: .get, parameters: nil)
        }
    }
    
}
