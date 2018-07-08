//
//  EventDetailPresenter.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import ReactiveSwift

class EventDetailPresenter: EventDetailPresenterProtocol {
    
    internal weak var view: EventDetailViewProtocol?
    internal var router: EventDetailRouterProtocol?
    internal var event: MutableProperty<EventProtocol>?
    
    var participantsCount: Property<Int> {
        guard let event = event else { return Property<Int>(value: 0) }
        return event.map { $0.participants.count }
    }
    
    init(view: EventDetailViewProtocol?, router: EventDetailRouterProtocol, event: EventProtocol) {
        self.view = view
        self.router = router
        self.event = MutableProperty(event)
    }
    
    func viewDidLoad() {
        guard let event = self.event?.value else { return }
        view?.setupView()
        view?.bindEventDetail(for: event)
    }
    
    func showParticipantDetail(for participant: ParticipantModel) {
        guard let view = view else { return }
        router?.presentParticipantDetailScreen(from: view, for: participant)
    }
    
    func participant(at index: Int) -> ParticipantModel? {
        return event?.value.participants[index]
    }
    
    func websiteTapAction() {
        guard let websiteUrl = event?.value.organaizer.website else { return }
        router?.openWebsite(url: websiteUrl)
    }
    
    func emailTapAction() {
        guard let email = event?.value.organaizer.email else { return }
        router?.writeEmail(to: email)
    }
    
    func wantToParticipateAction() {
        // if user is authorized, then call interactor's method to add particiant
        // otherwise navigate to login
    }
    
//    func add(event: EventProtocol) {
//        self.event?.value = event
//    }
    
}
