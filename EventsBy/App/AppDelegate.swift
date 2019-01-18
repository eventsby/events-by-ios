//
//  AppDelegate.swift
//  EventsBy
//
//  Created by Anton Polyakov on 3/31/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var router: AppRouter?
    private(set) var session: Session?
    
    static var shared: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        // AppSkin setup
        AppSkin.applyAppearance()
        AppSkin.customizeProgressHUD(for: window)
        
        let session = Session()
        self.session = session
        
        router = AppRouter(window: window, session: session)
        router?.start()
        
        // Logger setup
        LoggerService.shared.initialize()
        
        // Firebase/Google Analytics
        FirebaseApp.configure()
        
        return true
    }
}
