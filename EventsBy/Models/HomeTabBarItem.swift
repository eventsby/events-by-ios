//
//  TabBarItem.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/21/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation
import UIKit

protocol TabBarItemProtocol {
    
    var item: UIViewController { get }
    var button: UIControl { get }
    
}

class HomeTabBarItem: TabBarItemProtocol {
    
    let item: UIViewController
    let button: UIControl
    
    init(item: UIViewController, button: UIControl) {
        self.item = item
        self.button = button
    }
    
}
