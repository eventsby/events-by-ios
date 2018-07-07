//
//  AppSkin.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/7/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

struct AppSkin {
    
    static func applyAppearance() {
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().barTintColor = Colors.navBar.uiColor
        UINavigationBar.appearance().titleTextAttributes = [.font: Fonts.navBarTitle.uiFont, .foregroundColor: Colors.navBarTitle.uiColor]
        UINavigationBar.appearance().isTranslucent = false
        
        UINavigationBar.appearance().backIndicatorImage = #imageLiteral(resourceName: "icn_back").withRenderingMode(.alwaysOriginal)
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "icn_back").withRenderingMode(.alwaysOriginal)
    }
    
    static func setShadow(to view: UIView, path: CGRect? = nil, offset: CGSize? = nil) {
        if let offset = offset {
            view.layer.shadowOffset = offset
        }
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.2
    }
    
}
