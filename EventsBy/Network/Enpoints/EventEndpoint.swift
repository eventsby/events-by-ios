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
    
    func requestDetails() -> EndpointType {
        switch self {
        case .events(let page, let limit):
            var url = "\(NetworkConstants.baseUrl)\(NetworkConstants.version)"
            url.append("events?page=\(page)&size=\(limit)")
            return EndpointEntity(url: url, method: .get, params: nil)
        case .participate(let eventId, let user):
            var url = "\(NetworkConstants.baseUrl)\(NetworkConstants.version)"
            url.append("events/\(eventId)/participants")
            let userInfo: [String: String] = [
                "id": String(user.id)
            ]
            return EndpointEntity(url: url, method: .post, params: userInfo)
        case .removeParticipant(let eventId, let user):
            var url = "\(NetworkConstants.baseUrl)\(NetworkConstants.version)"
            url.append("events/\(eventId)/participants/\(user.id)")
            return EndpointEntity(url: url, method: .delete, params: nil)
        case .eventDetails(let eventId):
            var url = "\(NetworkConstants.baseUrl)\(NetworkConstants.version)"
            url.append("events/\(eventId)")
            return EndpointEntity(url: url, method: .get, params: nil)
        }
    }
    
}
