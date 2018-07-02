//
//  EventListRemoteDataManager.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation
import Alamofire

protocol EventListRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: EventListRemoteDataManagerOutputProtocol? { get set }
    
    func retrieveEventList()
}

protocol EventListRemoteDataManagerOutputProtocol: class {
    func onEventListRetrieved(_ events: [EventModel])
    func onError(_ error: Error?)
}

class EventListRemoteDataManager: EventListRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: EventListRemoteDataManagerOutputProtocol?
    
    let sessionManager = NetworkManager.shared.sessionManager
    
    func retrieveEventList() {
        sessionManager
            .request(Endpoints.Events.fetch.url, method: .get)
            .validate()
            .responseJSON { response in
                if response.result.error == nil, let data = response.data {
                    let events = try! JSONDecoder().decode(EventPageArray.self, from: data)
                    self.remoteRequestHandler?.onEventListRetrieved(events.content)
                } else {
                    self.remoteRequestHandler?.onError(response.result.error)
                }
        }
    }
    
}
