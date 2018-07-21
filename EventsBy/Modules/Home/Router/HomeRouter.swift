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
        guard let view = homeStoryboard.instantiateInitialViewController() as? HomeView else { return UIViewController() }
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
    
    static var homeStoryboard: UIStoryboard {
        return UIStoryboard(name: Storyboards.home.rawValue, bundle: Bundle.main)
    }
    
}
