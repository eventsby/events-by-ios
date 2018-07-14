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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        AppSkin.applyAppearance()
        let progressColor = Colors.loadingBarProgress.uiColor
        AppSkin.customizeProgressHUD(for: window, progressColor: progressColor)
        
        router = AppRouter(window: window)
        router?.start()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) { }

}
