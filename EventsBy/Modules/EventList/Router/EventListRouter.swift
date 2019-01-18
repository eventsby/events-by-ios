//
//  EventListRouter.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

class EventListRouter: EventListRouterProtocol {
    
    class func initializeEventListModule() -> UIViewController {
        let navController = StoryboardScene.Events.initialScene.instantiate()
        guard let view = navController.childViewControllers.first as? EventListView else { return UIViewController() }
        let interactor: EventListInteractorInputProtocol = EventListInteractor()
        let router: EventListRouterProtocol = EventListRouter()
        let presenter: EventListPresenterProtocol & EventListInteractorOutputProtocol = EventListPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
            
        return navController
    }
        
    func presentEventDetailScreen(from view: EventListViewProtocol, for event: EventModel) {
        let eventDetailVC = EventDetailRouter.createEventDetailModule(for: event)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(eventDetailVC, animated: true)
        }
    }
    
}
