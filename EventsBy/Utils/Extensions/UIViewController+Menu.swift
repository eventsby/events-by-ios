//
//  UIViewController+Menu.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/7/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func addMenuBarButton(_ action: @escaping () -> Void) {
        let menuBtn: UIBarButtonItem = .menuBtn {
            action()
        }
        navigationItem.leftBarButtonItem = menuBtn
        //SideMenuManager.default.menuAddPanGestureToPresent(toView: self.view)
    }
    
}
