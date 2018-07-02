//
//  EventListRouterProtocol.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

protocol EventListRouterProtocol: class {
    static func initializeEventListModule() -> UIViewController
    // Presenter -> Router
    func presentEventDetailScreen(from view: EventListViewProtocol, for event: EventModel)
}
