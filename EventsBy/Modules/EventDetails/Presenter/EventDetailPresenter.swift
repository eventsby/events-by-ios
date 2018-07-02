//
//  EventDetailPresenter.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

class EventDetailPresenter: EventDetailPresenterProtocol {
    
    weak var view: EventDetailViewProtocol?
    var router: EventDetailRouterProtocol?
    var event: EventModel?
    
    func viewDidLoad() {
        view?.showEventDetail(for: event!)
    }
    
}
