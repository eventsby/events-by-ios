//
//  EventListInteractor.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import ReactiveSwift

class EventListInteractor: EventListInteractorInputProtocol {
    
    weak var presenter: EventListInteractorOutputProtocol?
    var service: EventListServiceProtocol?
    
    func retrieveEventList(offset: Int = 0, limit: Int) {
        let paginationQuery: PaginationQueryType = PaginationQuery(offset: offset, limit: limit)
        loadEventsAction.apply(paginationQuery).take(duringLifetimeOf: self).start()
    }
    
    private(set) lazy var loadEventsAction: Action<PaginationQueryType, EventPageArrayProtocol, EventListServiceError> = {
        return Action { [weak self] pagination in
            guard let strongSelf = self, let service = strongSelf.service else { return .empty }
            return service
                .getEvents(page: pagination.offset, limit: pagination.limit)
                .observe(on: UIScheduler())
                .on(value: { [weak self] array in
                    self?.presenter?.didRetrieveEvents(array)
                    // TODO A.T 02.06.18: save events to the local db if needed
                    // Handle error too
                })
        }
    }()
    
}
