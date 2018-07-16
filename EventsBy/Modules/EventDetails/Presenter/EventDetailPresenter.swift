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
    internal var interactor: EventDetailInteractorInputProtocol?
    internal var event: MutableProperty<EventProtocol>?
    internal var userService: UserServiceProtocol?
    
    var participantsCount: Property<Int> {
        guard let event = event else { return Property<Int>(value: 0) }
        return event.map { $0.participants.count }
    }
    
    init(view: EventDetailViewProtocol?, router: EventDetailRouterProtocol, interactor: EventDetailInteractorInputProtocol, event: EventProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.event = MutableProperty(event)
    }
    
    func viewDidLoad() {
        guard let event = self.event?.value else { return }
        view?.setupView()
        view?.showLoading(initial: true)
        interactor?.getEventDetails(eventId: event.id)
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
        guard let view = self.view else { return }
        
        if let eventId = event?.value.id, let user = userService?.lastUser(), isAuthorized() {
            view.showLoading(initial: false)
            interactor?.participate(eventId: eventId, user: user)
        } else {
            router?.presentLoginScreen(from: view)
        }
    }
    
    private func isAuthorized() -> Bool {
        return PreferenceManager.shared.isAuthorized()
    }
    
//    func add(event: EventProtocol) {
//        self.event?.value = event
//    }
    
}

extension EventDetailPresenter: EventDetailInteractorOutputProtocol {
    
    func onParticipantAdded(_ event: EventProtocol) {
        self.event?.value = event
        view?.hideLoading()
        view?.participantAdded()
    }
    
    func onAlreadyParticipate() {
        view?.hideLoading()
        view?.alreadyParticipate()
    }
    
    func onError(_ error: Error?) {
        view?.hideLoading()
        view?.showError(error)
    }
    
    func onEventDetailError(_ error: Error?) {
        view?.hideLoading()
        view?.showError(error)
    }
    
    func onEventDetailRetrieved(_ event: EventProtocol) {
        view?.hideLoading()
        view?.showEventDetail(event)
    }
    
}
