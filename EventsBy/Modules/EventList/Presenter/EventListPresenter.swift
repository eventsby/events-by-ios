//
//  EventListPresenter.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

class EventListPresenter: EventListPresenterProtocol {
    
    weak var view: EventListViewProtocol?
    var interactor: EventListInteractorInputProtocol?
    var router: EventListRouterProtocol?
    
    func viewDidLoad() {
        view?.setupView()
        view?.showLoading()
        interactor?.retrieveEventList()
    }
    
    func showEventDetail(for event: EventModel) {
        guard let view = view else { return }
        router?.presentEventDetailScreen(from: view, for: event)
    }
    
}

extension EventListPresenter: EventListInteractorOutputProtocol {
    
    func didRetrieveEvents(_ events: [EventModel]) {
        view?.hideLoading()
        view?.showEvents(events)
    }
    
    func onError(_ error: Error?) {
        view?.hideLoading()
        view?.showError(error)
    }
    
}
