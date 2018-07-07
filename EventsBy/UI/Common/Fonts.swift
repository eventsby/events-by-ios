//
//  Fonts.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/7/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

enum Fonts {
    
    case navBarTitle
    case navBarButton
    
    case badgeText
    
    case custom(name: String, size: CGFloat)
    case button(size: CGFloat)
    
    var uiFont: UIFont {
        switch self {
        case .custom(let name, let size):
            return UIFont(name: name, size: size)!
        case .navBarTitle:
            return UIFont(name: "Montserrat-Medium", size: 16)!
        case .navBarButton:
            return UIFont(name: "Montserrat-Medium", size: 8)!
        case .button(let size):
            return UIFont(name: "Montserrat-SemiBold", size: size)!
        case .badgeText:
            return UIFont(name: "Montserrat-SemiBold", size: 13)!
        }
    }
    
}
