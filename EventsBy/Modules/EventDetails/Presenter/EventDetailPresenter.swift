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
    
    var participantsCount: Int {
        return event?.participants.count ?? 0
    }
    
    func viewDidLoad() {
        guard let event = self.event else { return }
        view?.setupView()
        view?.bindEventDetail(for: event)
    }
    
    func showParticipantDetail(for participant: ParticipantModel) {
        guard let view = view else { return }
        router?.presentParticipantDetailScreen(from: view, for: participant)
    }
    
    func participant(at index: Int) -> ParticipantModel? {
        return event?.participants[index]
    }
    
}
