//
//  HomeRouter.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/20/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

class HomeRouter: HomeRouterProtocol {
    
    class func initializeHomeModule() -> UIViewController {
        let view = StoryboardScene.Home.initialScene.instantiate()
        let router: HomeRouterProtocol = HomeRouter()
        let interactor: HomeInteractorInputProtocol & HomeManagerOutputProtocol = HomeInteractor()
        let manager: HomeManagerInputProtocol = HomeTabBarManager()
        let presenter: HomePresenterProtocol & HomeInteractorOutputProtocol = HomePresenter(view: view, interactor: interactor, router: router)
        
        interactor.presenter = presenter
        interactor.manager = manager
        manager.handler = interactor
        view.presenter = presenter
        
        return view
    }
    
}
