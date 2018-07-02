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
        guard let navController = eventsStoryboard.instantiateInitialViewController() else { return UIViewController() }
        guard let view = navController.childViewControllers.first as? EventListView else { return UIViewController() }
        let presenter: EventListPresenterProtocol & EventListInteractorOutputProtocol = EventListPresenter()
        let interactor: EventListInteractorInputProtocol & EventListRemoteDataManagerOutputProtocol = EventListInteractor()
        let remoteDataManager: EventListRemoteDataManagerInputProtocol = EventListRemoteDataManager()
        let router: EventListRouterProtocol = EventListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
            
        return navController
    }
    
    static var eventsStoryboard: UIStoryboard {
        return UIStoryboard(name: "Events", bundle: Bundle.main)
    }
    
    
    func presentEventDetailScreen(from view: EventListViewProtocol, for event: EventModel) {
        //let eventDetailVC = EventDetailRouter.createPostDetailModule(for: event)
        
        if let sourceView = view as? UIViewController {
            //sourceView.navigationController?.pushViewController(eventDetailVC, animated: true)
        }
    }
    
}
