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
        let view = StoryboardScene.EventDetails.initialScene.instantiate()
        let router: EventDetailRouterProtocol = EventDetailRouter()
        let interactor: EventDetailInteractorInputProtocol & EventDetailServiceOutputProtocol = EventDetailInteractor()
        let presenter: EventDetailPresenterProtocol & EventDetailInteractorOutputProtocol = EventDetailPresenter(view: view, router: router, interactor: interactor, event: event)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
    
    func presentParticipantDetailScreen(from view: EventDetailViewProtocol, for participant: ParticipantModel) {
//        let eventDetailVC = ParticipantDetailRouter.createParticipantDetailModule(for: participant)
        
//        if let sourceView = view as? UIViewController {
//            sourceView.navigationController?.pushViewController(eventDetailVC, animated: true)
//        }
        LoggerService.log.debug("Present participant detail screen for: \(participant.id)")
    }
    
    // change to goToLogin
//    func presentLoginScreen(from view: EventDetailViewProtocol) {
//        let loginVC = LoginRouter.initializeLoginModule()
//
//        if let sourceView = view as? UIViewController {
//            //sourceView.navigationController?.pushViewController(loginVC, animated: true)
//            sourceView.present(loginVC, animated: true, completion: nil)
//        }
//    }
    
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
