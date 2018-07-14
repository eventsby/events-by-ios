//
//  EventService.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/8/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation
import Alamofire

protocol EventDetailServiceInputProtocol: class {
    var remoteRequestHandler: EventDetailServiceOutputProtocol? { get set }
    
    func participateRequest(eventId: Int, user: UserDetailProtocol)
}

protocol EventDetailServiceOutputProtocol: class {
    func onParticipantAdded(_ event: EventModel)
    func onAlreadyParticipate()
    func onError(_ error: Error?)
}

class EventDetailService: EventDetailServiceInputProtocol {
    
    var remoteRequestHandler: EventDetailServiceOutputProtocol?
    
    let sessionManager = NetworkManager.shared.sessionManager
    
    func participateRequest(eventId: Int, user: UserDetailProtocol) {
        let endpoint = EventEndpoint.participate(eventId: eventId, user: user)
        
        sessionManager
            .request(endpoint.url, method: endpoint.method, parameters: endpoint.parameters, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<405)
            .responseJSON { response in
                if response.result.error == nil, let data = response.data {
                    if let res = response.result.value as? [String: Any], let error = res["error_description"] as? String, error == ServerResponseError.alreadyParticipate.raw() {
                        self.remoteRequestHandler?.onAlreadyParticipate()
                        return
                    }
                    guard let event = try? JSONDecoder().decode(EventModel.self, from: data) else {
                        self.remoteRequestHandler?.onError(ParseError.invalidFormat)
                        return
                    }
                    self.remoteRequestHandler?.onParticipantAdded(event)
                } else {
                    self.remoteRequestHandler?.onError(response.result.error)
                }
        }
    }
    
}
