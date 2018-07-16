//
//  EventDetailViewProtocol.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

protocol EventDetailViewProtocol: class {
    var presenter: EventDetailPresenterProtocol? { get set }
    
    func setupView()
    func bindEventDetail(for event: EventProtocol)
    
    func participantAdded()
    func alreadyParticipate()
    
    func participantRemoved()
    func userNotParticipating()
    
    func showError(_ error: Error?)
    func showEventDetail(_ event: EventProtocol)
    
    func showLoading(initial: Bool)
    func hideLoading()
    
    
}
