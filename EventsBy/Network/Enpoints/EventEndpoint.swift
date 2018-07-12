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
    
    case events
    
    func requestDetails() -> (url: String, method: HTTPMethod, parameters: [String : Any]?) {
        switch self {
        case .events:
            var url = "\(NetworkConstants.baseUrl)\(NetworkConstants.version)"
            url.append("events")
            return (url: url, method: .get, parameters: nil)
        }
    }
    
}
