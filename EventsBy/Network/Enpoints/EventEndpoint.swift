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
    case participate(eventId: Int, user: UserDetailProtocol)
    case removeParticipant(eventId: Int, user: UserDetailProtocol)
    case eventDetails(eventId: Int)
    
    func requestDetails() -> (url: String, method: HTTPMethod, parameters: [String : Any]?) {
        switch self {
        case .events(let page, let limit):
            var url = "\(NetworkConstants.baseUrl)\(NetworkConstants.version)"
            url.append("events?page=\(page)&size=\(limit)")
            return (url: url, method: .get, parameters: nil)
        case .participate(let eventId, let user):
            var url = "\(NetworkConstants.baseUrl)\(NetworkConstants.version)"
            url.append("events/\(eventId)/participants")
            let userInfo: [String: String] = [
                "id": String(user.id)
            ]
            return (url: url, method: .post, parameters: userInfo)
        case .removeParticipant(let eventId, let user):
            var url = "\(NetworkConstants.baseUrl)\(NetworkConstants.version)"
            url.append("events/\(eventId)/participants/\(user.id)")
            return (url: url, method: .delete, parameters: nil)
        case .eventDetails(let eventId):
            var url = "\(NetworkConstants.baseUrl)\(NetworkConstants.version)"
            url.append("events/\(eventId)")
            return (url: url, method: .get, parameters: nil)
        }
    }
    
}
