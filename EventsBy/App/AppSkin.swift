//
//  AppSkin.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/7/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit
import SVProgressHUD

struct AppSkin {
    
    static func applyAppearance() {
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().barTintColor = Asset.Colors.NavBar.navbarBackground.color
        UINavigationBar.appearance().titleTextAttributes = [.font: Fonts.navBarTitle.uiFont, .foregroundColor: Asset.Colors.NavBar.navbarTitle.color]
        UINavigationBar.appearance().isTranslucent = false
        
        UINavigationBar.appearance().backIndicatorImage = #imageLiteral(resourceName: "icn_back").withRenderingMode(.alwaysOriginal)
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "icn_back").withRenderingMode(.alwaysOriginal)
    }
    
    static func customizeProgressHUD(for window: UIWindow? = nil) {
        let progressColor = Asset.Colors.Main.progressHud.color
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setBackgroundColor(.clear)
        SVProgressHUD.setForegroundColor(progressColor)
        
        if let view = window {
            //SVProgressHUD.setContainerView(view)
        }
    }
    
    static func setShadow(to view: UIView, path: CGRect? = nil, offset: CGSize? = nil, radius: CGFloat?) {
        if let offset = offset {
            view.layer.shadowOffset = offset
        }
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = radius ?? 8
        view.layer.shadowOpacity = 0.2
    }
    
}
