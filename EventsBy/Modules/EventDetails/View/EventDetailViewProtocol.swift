//
//  EventDetailViewProtocol.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

protocol EventDetailViewProtocol: class {
    var presenter: EventDetailPresenterProtocol? { get set }
    
    func bindEventDetail(for event: EventModel)
    func setupView()
}
