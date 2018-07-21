//
//  Colors.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/7/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

enum Colors {
    
    case backgroundMain
    case navBar
    case navBarTitle
    case navBarButton
    
    case badgeBg
    case badgeText
    
    case buttonNormal
    case buttonSelected
    
    case inputFieldError
    case inputFieldTip
    case inputFieldText
    case inputFieldSeparator
    
    case primaryText
    
    case loadingBarProgress
    
    case tabBarIconNormal
    case tabBarIconSelected
    
    var uiColor: UIColor {
        switch self {
        case .backgroundMain:
            return UIColor(254, 254, 254, 1)
        case .navBar:
            return UIColor(254, 254, 254, 1)
        case .navBarTitle:
            return UIColor(59, 64, 83, 1)
        case .navBarButton:
            return UIColor(59, 64, 83, 1)
        case .badgeBg:
            return UIColor(100, 100, 100, 1)
        case .badgeText:
            return UIColor(255, 255, 255, 1)
        case .buttonSelected:
            return UIColor(253, 192, 44)
        case .buttonNormal:
            return .white
        case .inputFieldError:
            return .red
        case .inputFieldTip:
            return Colors.primaryText.uiColor.withAlphaComponent(0.5)
        case .inputFieldText:
            return Colors.primaryText.uiColor
        case .primaryText:
            return UIColor(46, 46, 46)
        case .inputFieldSeparator:
            return UIColor(200, 200, 200, 1)
        case .loadingBarProgress:
            return UIColor(255, 87, 0, 1)
        case .tabBarIconNormal:
            return UIColor(59, 64, 83, 1)
        case .tabBarIconSelected:
            return UIColor(255, 87, 0, 1)
        }
    }
    
}
