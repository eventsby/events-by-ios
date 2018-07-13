//
//  EventListPresenterProtocol.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

protocol EventListPresenterProtocol: class {
    var view: EventListViewProtocol? { get set }
    var interactor: EventListInteractorInputProtocol? { get set }
    var router: EventListRouterProtocol? { get set }
    var eventList: [EventModel] { get set }
    var eventsCount: Int { get }
    var totalItems: Int { get }
    
    // View -> Presenter
    func viewDidLoad()
    func pullToRefresh()
    func loadMore()
    func showEventDetail(for event: EventModel)
    func event(at index: Int) -> EventModel?
}
