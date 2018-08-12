//
//  MessageService.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/14/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit
import SwiftMessages

class MessangerService: NSObject {
    
    fileprivate var defaultMessageConfig: SwiftMessages.Config = {
        var config = SwiftMessages.Config()
        config.presentationStyle = .top
        config.interactiveHide = true
        return config
    }()
    
    private static let instance = MessangerService()
    
    @objc class func showError(error: Error) {
        showError(str: String(describing: error))
    }
    
    @objc class func showError(localizedKey: String) {
        showError(str: NSLocalizedString(localizedKey, comment: ""))
    }
    
    class func showError(str: String) {
        showMessage(str: str, config: instance.defaultMessageConfig, theme: .error)
    }
    
    class func showWarning(localizedKey: String) {
        showWarning(str: NSLocalizedString(localizedKey, comment: ""))
    }
    
    class func showWarning(str: String) {
        showMessage(str: str, config: instance.defaultMessageConfig, theme: .warning)
    }
    
    class func showSuccess(localizedKey: String) {
        showSuccess(str: NSLocalizedString(localizedKey, comment: ""))
    }
    
    class func showSuccess(str: String) {
        showMessage(str: str, config: instance.defaultMessageConfig, theme: .success)
    }
    
    class func showInfo(localizedKey: String) {
        showSuccess(str: NSLocalizedString(localizedKey, comment: ""))
    }
    
    class func showInfo(str: String) {
        showMessage(str: str, config: instance.defaultMessageConfig, theme: .info)
    }
    
}

private extension MessangerService {
    
    class func showMessage(str: String, config: SwiftMessages.Config, theme: Theme) {
        SwiftMessages.show(config: config) { () -> UIView in
            let view = MessageView.viewFromNib(layout: .messageView)
            view.configureTheme(theme)
            view.configureContent(title: "", body: str)
            view.button?.isHidden = true
            return view
        }
    }
    
}
