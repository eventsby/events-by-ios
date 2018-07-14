//
//  EventListRemoteDataManager.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation
import Alamofire

protocol EventListServiceInputProtocol: class {
    var remoteRequestHandler: EventListServiceOutputProtocol? { get set }
    
    func retrieveEventList(page: Int, limit: Int)
}

protocol EventListServiceOutputProtocol: class {
    func onEventListRetrieved(_ events: EventPageArray)
    func onError(_ error: Error?)
}

class EventListService: EventListServiceInputProtocol {
    
    var remoteRequestHandler: EventListServiceOutputProtocol?
    
    let sessionManager = NetworkManager.shared.sessionManager
    
    func retrieveEventList(page: Int = 0, limit: Int) {
        let endpoint = EventEndpoint.events(page: page, limit: limit)
        
        sessionManager
            .request(endpoint.url, method: endpoint.method)
            .validate()
            .responseJSON { response in
                if response.result.error == nil, let data = response.data {
                    guard let events = try? JSONDecoder().decode(EventPageArray.self, from: data) else {
                        self.remoteRequestHandler?.onError(response.result.error)
                        return
                    }
                    self.remoteRequestHandler?.onEventListRetrieved(events)
                } else {
                    self.remoteRequestHandler?.onError(response.result.error)
                }
        }
    }
    
}
