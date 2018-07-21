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
        let router: EventDetailRouterProtocol = EventDetailRouter()
        let interactor: EventDetailInteractorInputProtocol & EventDetailServiceOutputProtocol = EventDetailInteractor()
        let presenter: EventDetailPresenterProtocol & EventDetailInteractorOutputProtocol = EventDetailPresenter(view: view, router: router, interactor: interactor, event: event)
        let userService: UserServiceProtocol = UserService()
        presenter.userService = userService
        let service: EventDetailServiceInputProtocol = EventDetailService()
        
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.service = service
        service.remoteRequestHandler = interactor
        
        return viewController
    }
    
    static var eventDetails: UIStoryboard {
        return UIStoryboard(name: Storyboards.eventDetails.rawValue, bundle: Bundle.main)
    }
    
    func presentParticipantDetailScreen(from view: EventDetailViewProtocol, for participant: ParticipantModel) {
//        let eventDetailVC = ParticipantDetailRouter.createParticipantDetailModule(for: participant)
        
//        if let sourceView = view as? UIViewController {
//            sourceView.navigationController?.pushViewController(eventDetailVC, animated: true)
//        }
        Swift.print("Present participant detail screen for: \(participant.id)")
    }
    
    func presentLoginScreen(from view: EventDetailViewProtocol) {
        let loginVC = LoginRouter.initializeLoginModule()
        
        if let sourceView = view as? UIViewController {
            //sourceView.navigationController?.pushViewController(loginVC, animated: true)
            sourceView.present(loginVC, animated: true, completion: nil)
        }
    }
    
    func openWebsite(url: String) {
        guard let url = URL(string: url), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    func writeEmail(to email: String) {
        guard let url = URL(string: "mailto:\(email)"),
            UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
}
