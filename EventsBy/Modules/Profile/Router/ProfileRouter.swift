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
        guard let view = navController.childViewControllers.first as? ProfileView else { return UIViewController() }
        let interactor: ProfileInteractorInputProtocol & ProfileServiceOutputProtocol = ProfileInteractor()
        let router: ProfileRouterProtocol = ProfileRouter()
        let presenter: ProfilePresenterProtocol & ProfileInteractorOutputProtocol = ProfilePresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return navController
    }
    
    // change to goToLogin
//    func presentLogin(from view: ProfileViewProtocol) {
//        let delegate = view.presenter as? ProfilePresenter
//        let loginVC = LoginRouter.initializeLoginModule(modal: true, delegate: delegate)
//        
//        if let sourceView = view as? UIViewController {
//            sourceView.navigationController?.pushViewController(loginVC, animated: true)
//        }
//    }
    
}
