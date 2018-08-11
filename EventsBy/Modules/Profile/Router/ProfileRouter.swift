//
//  ProfileRouter.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/21/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

class ProfileRouter: ProfileRouterProtocol {
    
    class func initializeProfileModule() -> UIViewController {
        let navController = StoryboardScene.Profile.initialScene.instantiate()
        let view = StoryboardScene.Profile.profileView.instantiate()
        let interactor: ProfileInteractorInputProtocol & ProfileServiceOutputProtocol = ProfileInteractor()
        let router: ProfileRouterProtocol = ProfileRouter()
        let presenter: ProfilePresenterProtocol & ProfileInteractorOutputProtocol = ProfilePresenter(view: view, interactor: interactor, router: router)
        let service: ProfileServiceInputProtocol = ProfileService()
        let userService: UserServiceProtocol = UserService()
        
        presenter.userService = userService
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.service = service
        service.remoteRequestHandler = interactor
        
        return navController
    }
    
    func presentLogin(from view: ProfileViewProtocol) {
        let loginVC = LoginRouter.initializeLoginModule(modal: true, delegate: view.presenter as? ProfilePresenter)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
    
}
