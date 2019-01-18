//
//  HomeRoutable.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 1/18/19.
//  Copyright © 2019 Events-By. All rights reserved.
//

import UIKit

protocol HomeRoutable {
    
    func goToHome(animated: Bool)
    
}

extension HomeRoutable where Self: RouterType {
    
    func goToHome(animated: Bool = false) {
        let view = StoryboardScene.Home.initialScene.instantiate()
        let router = HomeRouter(session: session, view: view)
        let interactor: HomeInteractorInputProtocol & HomeManagerOutputProtocol = HomeInteractor()
        let manager: HomeManagerInputProtocol = HomeTabBarManager()
        let presenter: HomePresenterProtocol & HomeInteractorOutputProtocol = HomePresenter(view: view, interactor: interactor, router: router)
        
        interactor.presenter = presenter
        interactor.manager = manager
        manager.handler = interactor
        view.presenter = presenter
        
        let navVC = UINavigationController(rootViewController: view)
        AppDelegate.shared?.window?.setRootViewController(navVC, animated: animated, completion: nil)
    }
    
}
