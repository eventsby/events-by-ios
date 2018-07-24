//
//  CircledView.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/22/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

@IBDesignable
class CircledView: UIView {
    
    @IBInspectable var cutHeight: CGFloat = 50.0
    @IBInspectable var fillColor: UIColor = .white
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        createCircle()
    }
    
    private func createCircle() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addCurve(to: CGPoint(x: self.frame.size.width / 2, y: cutHeight),
                      controlPoint1: CGPoint(x: self.frame.size.width / 10, y: cutHeight / 2),
                      controlPoint2: CGPoint(x: self.frame.size.width / 3, y: cutHeight))
        path.addCurve(to: CGPoint(x: self.frame.size.width, y: 0),
                      controlPoint1: CGPoint(x: (self.frame.size.width / 2) + self.frame.size.width / 10, y: cutHeight),
                      controlPoint2: CGPoint(x: (self.frame.size.width / 2) + self.frame.size.width / 2.6, y: cutHeight / 2))
        
        fillColor.setFill()
        path.fill()
    }
}
