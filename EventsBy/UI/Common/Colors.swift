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
        }
    }
    
}
