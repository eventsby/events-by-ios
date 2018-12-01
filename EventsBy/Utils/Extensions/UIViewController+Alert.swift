//
//  UIViewController+Alert.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 12/1/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: L10n.Common.Alert.Action.ok, style: .default))
        self.present(ac, animated: true)
    }
    
}
