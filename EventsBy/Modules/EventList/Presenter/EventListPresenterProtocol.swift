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
    
    // View -> Presenter
    func viewDidLoad()
    func showEventDetail(for event: EventModel)
}
