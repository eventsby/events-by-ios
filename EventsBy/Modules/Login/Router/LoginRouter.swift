//
//  LoginRouter.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/9/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

class LoginRouter: LoginRouterProtocol {
    
    class func initializeLoginModule(modal: Bool = false, delegate: LoginScreenDelegate? = nil) -> UIViewController {
        let view = StoryboardScene.Login.initialScene.instantiate()
        let interactor: LoginInteractorInputProtocol & LoginServiceOutputProtocol = LoginInteractor()
        let router: LoginRouterProtocol = LoginRouter()
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter(view: view, interactor: interactor, router: router, isModal: modal)
        let service: LoginServiceInputProtocol = LoginService()
        let userService: UserServiceProtocol = UserService()
        
        presenter.delegate = delegate
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.service = service
        interactor.userService = userService
        service.remoteRequestHandler = interactor
        
        return view
    }
    
}
