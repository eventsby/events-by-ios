//
//  LoginInteractor.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/9/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

class LoginInteractor: LoginInteractorInputProtocol {
    
    weak var presenter: LoginInteractorOutputProtocol?
    var service: LoginServiceInputProtocol?
    var userService: UserServiceProtocol?
    
    func login(_ login: String, _ password: String) {
        service?.login(login: login, password: password)
    }
    
}

extension LoginInteractor: LoginServiceOutputProtocol {
    
    func onSuccessLogin(_ user: UserDetailProtocol) {
        presenter?.onSuccessLogin(user)
        userService?.saveUser(user)
    }
    
    func onInvalidCredentials() {
        presenter?.onInvalidCredentials()
    }
    
    func onError(_ error: Error?) {
        presenter?.onError(error)
    }
    
}
