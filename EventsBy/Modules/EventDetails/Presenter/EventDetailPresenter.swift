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
    
    var participants: [ParticipantModel] {
        return event?.participants ?? []
    }
    
    func viewDidLoad() {
        view?.setupView()
        view?.bindEventDetail(for: event!)
    }
    
    func showParticipantDetail(for participant: ParticipantModel) {
        guard let view = view else { return }
        router?.presentParticipantDetailScreen(from: view, for: participant)
    }
    
}
