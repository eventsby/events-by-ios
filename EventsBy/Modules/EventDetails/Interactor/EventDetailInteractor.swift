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
    
    func getEventDetails(eventId: Int) {
        service?.getEventDetails(eventId: eventId)
    }
    
    func participate(eventId: Int, user: UserDetailProtocol) {
        service?.participateRequest(eventId: eventId, user: user)
    }
    
    func removeParticipant(eventId: Int, user: UserDetailProtocol) {
        service?.removeParticipant(eventId: eventId, user: user)
    }
    
}

extension EventDetailInteractor: EventDetailServiceOutputProtocol {
    
    // Remove Participant
    
    func onParticipantRemoved(_ event: EventProtocol) {
        presenter?.onParticipantRemoved(event)
    }
    
    func onNotParticipating() {
        presenter?.userNotParticipating()
    }
    
    // Add Participant
    
    func onParticipantAdded(_ event: EventProtocol) {
        presenter?.onParticipantAdded(event)
    }
    
    func onAlreadyParticipate() {
        presenter?.onAlreadyParticipate()
    }
    
    func onError(_ error: Error?) {
        presenter?.onError(error)
    }
    
    // Event Detail
    
    func onEventDetailError(_ error: Error?) {
        presenter?.onEventDetailError(error)
    }
    
    func onEventDetailRetrieved(_ event: EventProtocol) {
        presenter?.onEventDetailRetrieved(event)
    }
    
}
