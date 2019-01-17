//
//  MapPresenter.swift
//  EventsBy
//
//  Created by Anton Paliakov on 1/17/19.
//  Copyright © 2019 Events-By. All rights reserved.
//

import Foundation

class MapPresenter: MapPresenterProtocol {

    internal weak var view: MapViewProtocol?
    internal var interactor: MapInteractorInputProtocol?
    internal var router: MapRouterProtocol?

    init(view: MapViewProtocol?, interactor: MapInteractorInputProtocol, router: MapRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {

    }

    func pullToRefresh() {

    }

    func loadMore() {

    }
}

extension MapPresenter: MapInteractorOutputProtocol {

}
