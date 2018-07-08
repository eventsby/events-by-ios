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
    var event: EventProtocol?
    
    var participantsCount: Int {
        return event?.participants.count ?? 0
    }
    
    init(view: EventDetailViewProtocol?, router: EventDetailRouterProtocol, event: EventProtocol) {
        self.view = view
        self.router = router
        self.event = event
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
    
    func websiteTapAction() {
        guard let websiteUrl = event?.organaizer.website else { return }
        router?.openWebsite(url: websiteUrl)
    }
    
    func emailTapAction() {
        guard let email = event?.organaizer.email else { return }
        router?.writeEmail(to: email)
    }
    
}
