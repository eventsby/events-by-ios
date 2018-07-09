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
    
    func login() {
        service?.login()
    }
    
}

extension LoginInteractor: LoginServiceOutputProtocol {
    
    func onSuccessLogin(_ token: TokenProtocol) {
        presenter?.onSuccessLogin()
    }
    
    func onInvalidCredentials() {
        presenter?.onInvalidCredentials()
    }
    
    func onError(_ error: Error?) {
        presenter?.onError(error)
    }
    
}
