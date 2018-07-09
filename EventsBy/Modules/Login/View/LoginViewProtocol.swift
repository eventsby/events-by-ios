//
//  LoginViewProtocol.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/9/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import UIKit

protocol LoginViewProtocol: class {
    var presenter: LoginPresenterProtocol? { get set }
    
    func onSuccessLogin()
    func showError(_ error: Error?)
    func showInvalidCredentialsError()
    func showLoading()
    func hideLoading()
    
    func setupView()
}
