//
//  EventListPresenter.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

class EventListPresenter: EventListPresenterProtocol {
    
    private struct Pagination {
        static let limit = 6
    }
    
    internal weak var view: EventListViewProtocol?
    internal var interactor: EventListInteractorInputProtocol?
    internal var router: EventListRouterProtocol?
    internal var eventList: [EventModel] = []
    
    var totalItems: Int = 0
    
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
        interactor?.retrieveEventList(offset: 0, limit: Pagination.limit)
    }
    
    // MARK: Actions
    
    func showEventDetail(for event: EventModel) {
        guard let view = view else { return }
        router?.presentEventDetailScreen(from: view, for: event)
    }
    
    func pullToRefresh() {
        self.eventList.removeAll()
        view?.reloadData()
        interactor?.retrieveEventList(offset: 0, limit: Pagination.limit)
    }
    
    func loadMore() {
        guard eventsCount < totalItems else { return }
        view?.showLoading()
        let page = eventsCount / Pagination.limit
        interactor?.retrieveEventList(offset: page, limit: Pagination.limit)
    }
    
}

extension EventListPresenter: EventListInteractorOutputProtocol {
    
    func didRetrieveEvents(_ events: EventPageArray) {
        self.eventList.append(contentsOf: events.content)
        self.totalItems = events.totalElements
        view?.hideLoading()
        view?.showEvents()
    }
    
    func onError(_ error: Error?) {
        view?.hideLoading()
        view?.showError(error)
    }
    
}
