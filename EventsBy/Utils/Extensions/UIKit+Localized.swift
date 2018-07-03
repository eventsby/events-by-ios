//
//  UIKit+Localize.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/3/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

extension UIButton {
    
    @IBInspectable var localizedTitle: String? {
        set {
            setTitle(newValue?.localized, for: .normal)
        }
        get {
            return currentTitle
        }
    }
    
}

extension UILabel {
    
    @IBInspectable var localizedTitle: String? {
        set {
            text = newValue?.localized
        }
        get {
            return text
        }
    }
    
}
