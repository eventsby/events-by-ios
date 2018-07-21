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
        guard let view = profileStoryboard.instantiateInitialViewController() as? ProfileView else { return UIViewController() }
        let interactor: ProfileInteractorInputProtocol & ProfileServiceOutputProtocol = ProfileInteractor()
        let router: ProfileRouterProtocol = ProfileRouter()
        let presenter: ProfilePresenterProtocol & ProfileInteractorOutputProtocol = ProfilePresenter(view: view, interactor: interactor, router: router)
        let service: ProfileServiceInputProtocol = ProfileService()
        let userService: UserServiceProtocol = UserService()
        
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.service = service
        interactor.userService = userService
        service.remoteRequestHandler = interactor
        
        return view
    }
    
    static var profileStoryboard: UIStoryboard {
        return UIStoryboard(name: "Profile", bundle: Bundle.main)
    }
    
}
