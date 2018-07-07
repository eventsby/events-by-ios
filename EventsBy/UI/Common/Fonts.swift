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
    
    case custom(name: String, size: CGFloat)
    
    var uiFont: UIFont {
        switch self {
        case .custom(let name, let size):
            return UIFont(name: name, size: size)!
        case .navBarTitle:
            return UIFont(name: "Montserrat-Medium", size: 17)!
        }
    }
    
}
