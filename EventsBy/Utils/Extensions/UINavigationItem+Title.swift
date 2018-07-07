//
//  UINavigationItem+Title.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/7/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

extension UINavigationItem {
    
    var backBarButtonTitle: String? {
        get {
            return nil
        }
        set {
            backBarButtonItem = UIBarButtonItem(title: newValue, style: .plain, target: nil, action: nil)
        }
    }
    
}
