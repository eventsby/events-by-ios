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
    
    func retrieveEventList()
}

protocol EventDetailServiceOutputProtocol: class {
    func onEventListRetrieved(_ events: [EventModel])
    func onError(_ error: Error?)
}

class EventDetailService: EventDetailServiceInputProtocol {
    
    var remoteRequestHandler: EventDetailServiceOutputProtocol?
    
    let sessionManager = NetworkManager.shared.sessionManager
    
    func retrieveEventList() {
        
    }
    
}
