//
//  File.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/20/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

protocol HomeViewProtocol: class {
    var presenter: HomePresenterProtocol? { get set }
    
    func controllerSwitched(to: TabBarItemProtocol, from: TabBarItemProtocol)
    func setup(_ items: [TabBarItemProtocol])
    func setupView()
}
