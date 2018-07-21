//
//  HomeInteractorProtocol.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/21/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

protocol HomeInteractorOutputProtocol: class {
    // Interactor -> Presenter
    func controllerSwitched(to: TabBarItemProtocol, from: TabBarItemProtocol)
    func setupTabBar(_ items: [TabBarItemProtocol])
}

protocol HomeInteractorInputProtocol: class {
    var presenter: HomeInteractorOutputProtocol? { get set }
    var manager: HomeManagerInputProtocol? { get set }
    
    // Presenter -> Interactor
    func setup()
}
