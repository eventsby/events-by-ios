//
//  UIViewController+Present.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 12/1/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentModally(animated: Bool = true, completion: (() -> Void)? = nil) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let view = UIViewController()
        window.rootViewController = view
        window.makeKeyAndVisible()
        DispatchQueue.main.async {
            view.present(self, animated: animated, completion: completion)
            _ = window
        }
    }
    
}
