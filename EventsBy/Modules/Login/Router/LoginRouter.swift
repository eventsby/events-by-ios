//
//  LoginRouter.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/9/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

class LoginRouter: LoginRouterProtocol {
    
    class func initializeLoginModule() -> UIViewController {
        guard let navController = loginStoryboard.instantiateInitialViewController() else { return UIViewController() }
        guard let view = navController.childViewControllers.first as? LoginView else { return UIViewController() }
        let interactor: LoginInteractorInputProtocol & LoginServiceOutputProtocol = LoginInteractor()
        let router: LoginRouterProtocol = LoginRouter()
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter(view: view, interactor: interactor, router: router)
        let service: LoginServiceInputProtocol = LoginService()
        let userService: UserServiceProtocol = UserService()
        
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.service = service
        interactor.userService = userService
        service.remoteRequestHandler = interactor
        
        return navController
    }
    
    static var loginStoryboard: UIStoryboard {
        return UIStoryboard(name: "Login", bundle: Bundle.main)
    }
    
//    func presentEventDetailScreen(from view: EventListViewProtocol, for event: EventModel) {
//        let eventDetailVC = EventDetailRouter.createEventDetailModule(for: event)
//
//        if let sourceView = view as? UIViewController {
//            sourceView.navigationController?.pushViewController(eventDetailVC, animated: true)
//        }
//    }
    
}
