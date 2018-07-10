//
//  LoginPresenter.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/9/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

class LoginPresenter: LoginPresenterProtocol {
    
    internal weak var view: LoginViewProtocol?
    internal var interactor: LoginInteractorInputProtocol?
    internal var router: LoginRouterProtocol?
    
    init(view: LoginViewProtocol?, interactor: LoginInteractorInputProtocol, router: LoginRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view?.setupView()
        view?.showLoading()
    }
    
    func loginAction(_ login: String, _ password: String) {
        interactor?.login(login, password)
    }
    
    func closeAction() {
        view?.onClose()
    }
    
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    
    func onSuccessLogin(_ user: UserDetailProtocol) {
        view?.hideLoading()
        view?.onSuccessLogin()
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
