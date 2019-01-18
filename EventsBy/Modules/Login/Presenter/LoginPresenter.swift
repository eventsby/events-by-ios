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
    internal var router: RouterType?
    internal weak var delegate: LoginScreenDelegate?
    internal var isModal: Bool
    
    let login: MutableProperty<String?> = MutableProperty(nil)
    let password: MutableProperty<String?> = MutableProperty(nil)
    
    var loginButtonEnabled: Property<Bool> {
        let enabled = Property.combineLatest(login, password).map { login, password -> Bool in
            return login?.isEmpty == false && password?.isEmpty == false
        }
        return enabled
    }
    
    init(view: LoginViewProtocol?, interactor: LoginInteractorInputProtocol, router: RouterType?, isModal: Bool) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.isModal = isModal
    }
    
    func viewDidLoad() {
        view?.setupView()
    }
    
    func viewWillDisappear() {
        delegate?.onLoginScreenDismissed()
    }
    
    // MARK: Actions
    
    func loginAction() {
        guard let login = self.login.value, let password = self.password.value else { return }
        interactor?.login(login, password)
        view?.showLoading()
    }
    
    func closeAction() {
        guard !isModal else { return }
        view?.onClose(animated: true)
    }
    
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    
    func onSuccessLogin(_ user: UserDetailProtocol) {
        view?.hideLoading()
        view?.onSuccessLogin()
        view?.onClose(animated: true)
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
