//
//  ProfileRouterProtocol.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/21/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileRouterProtocol: class {
    static func initializeProfileModule() -> UIViewController
    
    //func presentLogin(from view: ProfileViewProtocol)
}
