//
//  MapRouter.swift
//  EventsBy
//
//  Created by Anton Paliakov on 1/17/19.
//  Copyright © 2019 Events-By. All rights reserved.
//

import UIKit

class MapRouter: MapRouterProtocol {

    static func initializeMapModule() -> UIViewController {
        let navController = StoryboardScene.Map.initialScene.instantiate()
        guard let view = navController.childViewControllers.first as? MapView else { return UIViewController() }
        let interactor: MapInteractorInputProtocol = MapInteractor()
        let router: MapRouterProtocol = MapRouter()
        let presenter: MapPresenterProtocol & MapInteractorOutputProtocol = MapPresenter(view: view, interactor: interactor, router: router)
        let service: MapServiceProtocol = MapService()

        view.presenter = presenter
        interactor.presenter = presenter
        interactor.service = service

        return navController
    }
    
}
