//
//  LoginPresenter.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/9/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import ReactiveSwift

class LoginPresenter: LoginPresenterProtocol {
    
    internal weak var view: LoginViewProtocol?
    internal var interactor: LoginInteractorInputProtocol?
    internal var router: LoginRouterProtocol?
    
    let login: MutableProperty<String?> = MutableProperty(nil)
    let password: MutableProperty<String?> = MutableProperty(nil)
    
    init(view: LoginViewProtocol?, interactor: LoginInteractorInputProtocol, router: LoginRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view?.setupView()
    }
    
    func loginAction() {
        guard let login = self.login.value, let password = self.password.value else { return }
        interactor?.login(login, password)
        view?.showLoading()
    }
    
    func closeAction() {
        view?.onClose()
    }
    
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    
    func onSuccessLogin(_ user: UserDetailProtocol) {
        view?.hideLoading()
        view?.onSuccessLogin()
        view?.onClose()
    }
    
    func onInvalidCredentials() {
        view?.hideLoading()
        view?.showInvalidCredentialsError()
    }
    
    func onError(_ error: Error?) {
        view?.hideLoading()
        view?.showError(error)
    }
    
}
