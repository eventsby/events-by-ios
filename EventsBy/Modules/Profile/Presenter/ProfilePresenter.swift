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
    internal var userService: UserServiceProtocol?
    
    var userStatus: UserStatus {
        let isAuthorized = PreferenceManager.shared.isAuthorized()
        guard let user = userService?.lastUser(), isAuthorized else {
            return .anonymous
        }
        return .registered(user)
    }
    
    init(view: ProfileViewProtocol?, interactor: ProfileInteractorInputProtocol, router: ProfileRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view?.setupView()
        
        switch userStatus {
        case .registered(let user):
            view?.showLoading()
            interactor?.getUserInfo(user: user)
        case .anonymous:
            // TODO navigate to login
            break
        }
    }
    
}

extension ProfilePresenter: ProfileInteractorOutputProtocol {
    
    func onSuccessUserInfo(_ user: UserDetailProtocol) {
        view?.hideLoading()
        view?.onSuccessUserInfo(user)
    }
    
    func onError(_ error: Error?) {
        view?.hideLoading()
        view?.showError(error)
    }
    
}
