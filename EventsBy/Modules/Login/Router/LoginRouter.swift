//
//  LoginRouter.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/9/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

class LoginRouter: LoginRouterProtocol {
    
    class func initializeLoginModule(modal: Bool = false) -> UIViewController {
        guard let view = loginStoryboard.instantiateInitialViewController() as? LoginView else { return UIViewController() }
        let interactor: LoginInteractorInputProtocol & LoginServiceOutputProtocol = LoginInteractor()
        let router: LoginRouterProtocol = LoginRouter()
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter(view: view, interactor: interactor, router: router, isModal: modal)
        let service: LoginServiceInputProtocol = LoginService()
        let userService: UserServiceProtocol = UserService()
        
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.service = service
        interactor.userService = userService
        service.remoteRequestHandler = interactor
        
        return view
    }
    
    static var loginStoryboard: UIStoryboard {
        return UIStoryboard(name: Storyboards.login.rawValue, bundle: Bundle.main)
    }
    
}
