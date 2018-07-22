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
        guard let navController = profileStoryboard.instantiateInitialViewController() else { return UIViewController() }
        guard let view = navController.childViewControllers.first as? ProfileView else { return UIViewController() }
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
    
    static var profileStoryboard: UIStoryboard {
        return UIStoryboard(name: Storyboards.profile.rawValue, bundle: Bundle.main)
    }
    
}
