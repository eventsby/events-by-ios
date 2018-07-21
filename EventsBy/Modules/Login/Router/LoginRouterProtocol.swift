//
//  LoginRouterProtocol.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/9/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation
import UIKit

protocol LoginRouterProtocol: class {
    static func initializeLoginModule(modal: Bool) -> UIViewController
}
