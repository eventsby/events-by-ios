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
    
    var isUserParticipating: Property<Bool> {
        guard let event = event else { return Property<Bool>(value: false) }
        guard let userId = userService?.lastUser()?.id else { return Property<Bool>(value: false) }
        return event.map { $0.participants.contains(where: { user in user.id == userId }) }
    }
    
    var userStatus: UserStatus {
        let isAuthorized = PreferenceManager.shared.isAuthorized()
        guard let user = userService?.lastUser(), isAuthorized else {
            return .anonymous
        }
        return .registered(user)
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
        guard let view = self.view, let eventId = event?.value.id else { return }
        
        switch userStatus {
        case .registered(let user):
            view.showLoading(initial: false)
            if isUserParticipating.value {
                interactor?.removeParticipant(eventId: eventId, user: user)
            } else {
                interactor?.participate(eventId: eventId, user: user)
            }
        case .anonymous:
            router?.presentLoginScreen(from: view)
        }
    }
    
}

extension EventDetailPresenter: EventDetailInteractorOutputProtocol {
    
    func onParticipantRemoved(_ event: EventProtocol) {
        self.event?.value = event
        view?.hideLoading()
        view?.participantRemoved()
    }
    
    func userNotParticipating() {
        view?.hideLoading()
        view?.userNotParticipating()
    }
    
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
        self.event?.value = event
        view?.hideLoading()
        view?.showEventDetail(event)
    }
    
}
