//
//  EventDetailRouter.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

class EventDetailRouter: EventDetailRouterProtocol {
    
    class func createEventDetailModule(for event: EventModel) -> UIViewController {
        guard let viewController = eventDetails.instantiateInitialViewController() else { return UIViewController() }
        guard let view = viewController as? EventDetailView else { return UIViewController() }
        let presenter: EventDetailPresenterProtocol = EventDetailPresenter()
        let router: EventDetailRouterProtocol = EventDetailRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.event = event
        presenter.router = router
        
        return viewController
    }
    
    static var eventDetails: UIStoryboard {
        return UIStoryboard(name: "EventDetails", bundle: Bundle.main)
    }
    
}
