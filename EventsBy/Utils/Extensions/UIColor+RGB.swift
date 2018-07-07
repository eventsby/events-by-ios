//
//  UIColor+RGB.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/7/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(_ rc: Double, _ gc: Double, _ bc: Double, _ ac: Double) {
        self.init(red: CGFloat(rc / 255.0), green: CGFloat(gc / 255.0), blue: CGFloat(bc / 255.0), alpha: CGFloat(ac))
    }
    
    convenience init(_ rc: Double, _ gc: Double, _ bc: Double) {
        self.init(rc, gc, bc, 1)
    }
    
}
