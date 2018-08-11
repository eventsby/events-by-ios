//
//  AppDelegate.swift
//  EventsBy
//
//  Created by Anton Polyakov on 3/31/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var router: AppRouter?
    static var shared: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        AppSkin.applyAppearance()
        AppSkin.customizeProgressHUD(for: window)
        
        router = AppRouter(window: window)
        router?.start()
        
        return true
    }
}
