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
        let homeVC = HomeRouter.initializeHomeModule()
        
        window.rootViewController = homeVC
        window.makeKeyAndVisible()
    }
    
    func goToLogin(modal: Bool = false) {
        guard let rootVC = self.window.rootViewController else { return }
        let loginVC = LoginRouter.initializeLoginModule(modal: modal)
        rootVC.present(loginVC, animated: true, completion: nil)
    }
    
}
