//
//  UIView.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set (newRadius) {
            self.layer.cornerRadius = newRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set (newWidth) {
            self.layer.borderWidth = newWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return (self.layer.borderColor != nil) ? UIColor(cgColor: self.layer.borderColor!) : nil
        }
        set (newColor) {
            self.layer.borderColor = newColor?.cgColor
        }
    }
    
}
