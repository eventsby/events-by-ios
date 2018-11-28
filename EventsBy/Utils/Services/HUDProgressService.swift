//
//  HUDProgressService.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/14/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation
import SVProgressHUD

class HUDProgressService: NSObject {
    
    private static let instance = HUDProgressService()
    
    class func show(view: UIView?) {
        SVProgressHUD.setContainerView(view)
        SVProgressHUD.show()
    }
    
    class func dismiss() {
        SVProgressHUD.dismiss()
    }
    
}
