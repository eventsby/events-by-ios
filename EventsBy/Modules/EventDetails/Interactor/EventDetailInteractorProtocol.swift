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
    func onParticipantAdded(_ event: EventModel)
    func onAlreadyParticipate()
    func onError(_ error: Error?)
}

protocol EventDetailInteractorInputProtocol: class {
    var presenter: EventDetailInteractorOutputProtocol? { get set }
    var service: EventDetailServiceInputProtocol? { get set }
    
    // Presenter -> Interactor
    func participate(eventId: Int, user: UserDetailProtocol)
}
