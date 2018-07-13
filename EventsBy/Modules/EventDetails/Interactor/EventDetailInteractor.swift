//
//  EventDetailInteractor.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/8/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

class EventDetailInteractor: EventDetailInteractorInputProtocol {
    
    weak var presenter: EventDetailInteractorOutputProtocol?
    var service: EventDetailServiceInputProtocol?
    
    func retrieveEventList() {
        service?.retrieveEventList()
    }
    
}

extension EventDetailInteractor: EventListServiceOutputProtocol {
    
    func onEventListRetrieved(_ events: EventPageArray) {
        presenter?.didRetrieveEvents(events)
        // TODO A.T 02.06.18: save events to the local db if needed
    }
    
    func onError(_ error: Error?) {
        presenter?.onError(error)
    }
    
}
