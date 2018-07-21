//
//  HomeInteractor.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/21/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit // TODO REMOVE

class HomeInteractor: HomeInteractorInputProtocol {
    
    weak var presenter: HomeInteractorOutputProtocol?
    var manager: HomeManagerInputProtocol?
    
    func setup() {
        manager?.initialize()
    }
    
}

extension HomeInteractor: HomeManagerOutputProtocol {
    
    func controllerSwitched(to: TabBarItemProtocol, from: TabBarItemProtocol) {
        presenter?.controllerSwitched(to: to, from: to)
    }
    
    func setupTabBar(_ items: [TabBarItemProtocol]) {
        presenter?.setupTabBar(items)
    }
    
}
