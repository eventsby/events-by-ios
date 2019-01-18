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
    private(set) var session: SessionType?
    
    init(window: UIWindow, session: SessionType) {
        self.window = window
        self.session = session
    }
    
    func start() {
        guard let session = session else { return }
        goToHome(animated: false)
    }
    
    func goToHome(animated: Bool) {
        guard let session = session else { return }
        let dummyView = UIViewController()
        window.rootViewController = dummyView
        window.makeKeyAndVisible()
        
        let router = InitialHomeRouter(session: session, view: dummyView)
        router.goToHome(animated: animated)
    }
    
    func goToLogin(modal: Bool = false, animated: Bool = false) {
        guard let session = session else { return }
        let vc = UIViewController()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        
        let router = InitialLoginRouter(session: session, view: vc)
        router.goToLogin(modal: true, animated: animated, delegate: nil)
    }
    
}
