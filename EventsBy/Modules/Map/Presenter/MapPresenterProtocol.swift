//
//  MapPresenterProtocol.swift
//  EventsBy
//
//  Created by Anton Paliakov on 1/17/19.
//  Copyright © 2019 Events-By. All rights reserved.
//

import UIKit

protocol MapPresenterProtocol: class {
    var view: MapViewProtocol? { get set }
    var interactor: MapInteractorInputProtocol? { get set }
    var router: MapRouterProtocol? { get set }

    // View -> Presenter
    func viewDidLoad()
    func pullToRefresh()
    func loadMore()
}
