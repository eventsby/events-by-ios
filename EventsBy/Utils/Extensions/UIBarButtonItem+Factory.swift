//
//  UIBarButtonItem+Factory.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/7/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

extension UIBarButtonItem {
    
    static func menuBtn(_ action: @escaping () -> Void) -> UIBarButtonItem {
        let btn = LabledButton(frame: .zero)
        btn.image = #imageLiteral(resourceName: "icn_menu")
        btn.text = "menu_btn_title".localized
        btn.space = 0
        btn.sizeToFit()
        btn.tintColor = Colors.navBarButton.uiColor
        btn.reactive.controlEvents(.touchUpInside).take(duringLifetimeOf: btn).observeValues { _ in
            action()
        }
        return UIBarButtonItem(customView: btn)
    }
    
}
