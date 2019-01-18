//
//  HomePresenter.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/20/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation

class HomePresenter: HomePresenterProtocol {
    
    internal weak var view: HomeViewProtocol?
    internal var interactor: HomeInteractorInputProtocol?
    internal var router: RouterType?
    
    init(view: HomeViewProtocol?, interactor: HomeInteractorInputProtocol?, router: RouterType?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        view?.setupView()
        interactor?.setup()
    }
    
}

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func controllerSwitched(to: TabBarItemProtocol, from: TabBarItemProtocol) {
        view?.controllerSwitched(to: to, from: from)
    }
    
    func setupTabBar(_ items: [TabBarItemProtocol]) {
        view?.setup(items)
    }
    
}
