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
    case tabBarButton
    
    case badgeText
    
    case inputFieldError
    case inputFieldTip
    case inputFieldText
    
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
        case .inputFieldError:
            return UIFont(name: "Montserrat-Medium", size: 9)!
        case .inputFieldText:
            return UIFont(name: "Montserrat-Medium", size: 17)!
        case .inputFieldTip:
             return UIFont(name: "Montserrat-SemiBold", size: 13)!
        case .tabBarButton:
            return UIFont(name: "Montserrat-Medium", size: 9)!
        }
    }
    
}
