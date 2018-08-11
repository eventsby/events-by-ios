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
        btn.text = L10n.Common.Menu.Button.title
        btn.space = 0
        btn.sizeToFit()
        btn.tintColor = Asset.Colors.NavBar.navbarButton.color
        btn.reactive.controlEvents(.touchUpInside).take(duringLifetimeOf: btn).observeValues { _ in
            action()
        }
        return UIBarButtonItem(customView: btn)
    }
    
}
