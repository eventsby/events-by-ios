//
//  EventListInteractor.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

class EventListInteractor: EventListInteractorInputProtocol {
    
    weak var presenter: EventListInteractorOutputProtocol?
    var remoteDatamanager: EventListRemoteDataManagerInputProtocol?
    
    func retrieveEventList() {
        remoteDatamanager?.retrieveEventList()
    }
    
}

extension EventListInteractor: EventListRemoteDataManagerOutputProtocol {
    
    func onEventListRetrieved(_ events: [EventModel]) {
        presenter?.didRetrieveEvents(events)
        // TODO A.T 02.06.18: save events to the local db if needed
    }
    
    func onError(_ error: Error?) {
        presenter?.onError(error)
    }
    
}
