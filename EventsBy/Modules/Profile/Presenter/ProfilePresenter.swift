//
//  ProfilePresenter.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/21/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

class ProfilePresenter: ProfilePresenterProtocol {
    
    internal weak var view: ProfileViewProtocol?
    internal var interactor: ProfileInteractorInputProtocol?
    internal var router: ProfileRouterProtocol?
    
    init(view: ProfileViewProtocol?, interactor: ProfileInteractorInputProtocol, router: ProfileRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view?.setupView()
    }
    
}

extension ProfilePresenter: ProfileInteractorOutputProtocol {
    
    func onSuccessUserInfo(_ user: UserDetailProtocol) {
        view?.hideLoading()
        view?.onSuccessUserInfo()
    }
    
    func onError(_ error: Error?) {
        view?.hideLoading()
        view?.showError(error)
    }
    
}
