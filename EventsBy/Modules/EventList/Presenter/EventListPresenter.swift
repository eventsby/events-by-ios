//
//  EventListPresenter.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

class EventListPresenter: EventListPresenterProtocol {
    
    internal weak var view: EventListViewProtocol?
    internal var interactor: EventListInteractorInputProtocol?
    internal var router: EventListRouterProtocol?
    internal var eventList: [EventModel] = []
    
    var eventsCount: Int {
        return eventList.count
    }
    
    func event(at index: Int) -> EventModel? {
        return eventList[index]
    }
    
    init(view: EventListViewProtocol?, interactor: EventListInteractorInputProtocol, router: EventListRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view?.setupView()
        view?.showLoading()
        interactor?.retrieveEventList()
    }
    
    // MARK: Actions
    
    func showEventDetail(for event: EventModel) {
        guard let view = view else { return }
        router?.presentEventDetailScreen(from: view, for: event)
    }
    
    func pullToRefresh() {
        interactor?.retrieveEventList()
    }
    
}

extension EventListPresenter: EventListInteractorOutputProtocol {
    
    func didRetrieveEvents(_ events: [EventModel]) {
        self.eventList = events
        view?.hideLoading()
        view?.showEvents()
    }
    
    func onError(_ error: Error?) {
        view?.hideLoading()
        view?.showError(error)
    }
    
}
