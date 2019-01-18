//
//  BaseRouter.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 1/18/19.
//  Copyright © 2019 Events-By. All rights reserved.
//

import UIKit
import Foundation

protocol RouterType: class {
    var view: UIViewController? { get }
    var session: SessionType { get }
}

class BaseRouter: RouterType {
    
    let session: SessionType
    private(set) weak var view: UIViewController?
    
    init(session: SessionType, view: UIViewController) {
        self.session = session
        self.view = view
    }
    
}

extension RouterType {
    
    var navigationController: UINavigationController? {
        let nc = view?.navigationController ?? view as? UINavigationController
        return nc
    }
    
}
