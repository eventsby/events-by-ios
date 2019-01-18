//
//  LoginRouter.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/9/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

protocol LoginRoutable {
    
    func goToLogin(modal: Bool, animated: Bool, delegate: LoginScreenDelegate?)
    
}

extension LoginRoutable where Self: RouterType {
    
    func goToLogin(modal: Bool, animated: Bool = false, delegate: LoginScreenDelegate?) {
        let view = StoryboardScene.Login.initialScene.instantiate()
        let interactor: LoginInteractorInputProtocol & LoginServiceOutputProtocol = LoginInteractor()
        let router = LoginRouter(session: session, view: view)
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter(view: view, interactor: interactor, router: router, isModal: modal)
        
        presenter.delegate = delegate
        view.presenter = presenter
        interactor.presenter = presenter
        
        let rootVC = UINavigationController(rootViewController: view)
        AppDelegate.shared?.window?.setRootViewController(rootVC, animated: animated, completion: nil)
    }
}


/*
class LoginRouter: LoginRouterProtocol {
    
    class func initializeLoginModule(modal: Bool = false, delegate: LoginScreenDelegate? = nil) -> UIViewController {
        let view = StoryboardScene.Login.initialScene.instantiate()
        let interactor: LoginInteractorInputProtocol & LoginServiceOutputProtocol = LoginInteractor()
        let router: LoginRouterProtocol = LoginRouter()
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter(view: view, interactor: interactor, router: router, isModal: modal)
        
        presenter.delegate = delegate
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
    
}
*/
