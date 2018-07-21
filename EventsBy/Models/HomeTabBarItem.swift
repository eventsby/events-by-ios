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
    var button: UIButton { get }
    
}

class HomeTabBarItem: TabBarItemProtocol {
    
    let item: UIViewController
    let button: UIButton
    
    init(item: UIViewController, button: UIButton) {
        self.item = item
        self.button = button
    }
    
}
