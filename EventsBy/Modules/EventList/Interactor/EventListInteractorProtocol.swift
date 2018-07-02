//
//  EventListInteractorProtocol.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

protocol EventListInteractorOutputProtocol: class {
    // Interactor -> Presenter
    func didRetrieveEvents(_ events: [EventModel])
    func onError(_ error: Error?)
}

protocol EventListInteractorInputProtocol: class {
    var presenter: EventListInteractorOutputProtocol? { get set }
    var remoteDatamanager: EventListRemoteDataManagerInputProtocol? { get set }
    
    // Presenter -> Interactor
    func retrieveEventList()
}
