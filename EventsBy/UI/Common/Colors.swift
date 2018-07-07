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
    
    var uiColor: UIColor {
        switch self {
        case .backgroundMain:
            return UIColor(254, 254, 254, 1)
        case .navBar:
            return UIColor(254, 254, 254, 1)
        case .navBarTitle:
            return UIColor(59, 64, 83, 1)
        }
    }
    
}
