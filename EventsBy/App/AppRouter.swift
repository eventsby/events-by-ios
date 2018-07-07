//
//  AppRouter.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/7/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

final class AppRouter {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let eventListVC = EventListRouter.initializeEventListModule()
        
        window.rootViewController = eventListVC
        window.makeKeyAndVisible()
    }
    
}
