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
    
    func participate(eventId: Int, user: UserDetailProtocol) {
        service?.participateRequest(eventId: eventId, user: user)
    }
    
}

extension EventDetailInteractor: EventDetailServiceOutputProtocol {
    
    func onParticipantAdded(_ event: EventModel) {
        presenter?.onParticipantAdded(event)
    }
    
    func onAlreadyParticipate() {
        presenter?.onAlreadyParticipate()
    }
    
    func onError(_ error: Error?) {
        presenter?.onError(error)
    }
    
}
