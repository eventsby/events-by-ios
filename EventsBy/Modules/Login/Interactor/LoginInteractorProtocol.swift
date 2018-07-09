//
//  LoginInteractorProtocol.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/9/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

protocol LoginInteractorOutputProtocol: class {
    // Interactor -> Presenter
    func onSuccessLogin()
    func onInvalidCredentials()
    func onError(_ error: Error?)
}

protocol LoginInteractorInputProtocol: class {
    var presenter: LoginInteractorOutputProtocol? { get set }
    var service: LoginServiceInputProtocol? { get set }
    
    // Presenter -> Interactor
    func login()
}
