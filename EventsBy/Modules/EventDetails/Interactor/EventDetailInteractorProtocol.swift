//
//  EventDetailInteractorProtocol.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/8/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

protocol EventDetailInteractorOutputProtocol: class {
    // Interactor -> Presenter
    func onParticipantAdded(_ event: EventProtocol)
    func onAlreadyParticipate()
    func onError(_ error: Error?)
    
    func onEventDetailError(_ error: Error?)
    func onEventDetailRetrieved(_ event: EventProtocol)
}

protocol EventDetailInteractorInputProtocol: class {
    var presenter: EventDetailInteractorOutputProtocol? { get set }
    var service: EventDetailServiceInputProtocol? { get set }
    
    // Presenter -> Interactor
    func participate(eventId: Int, user: UserDetailProtocol)
    func getEventDetails(eventId: Int)
}
