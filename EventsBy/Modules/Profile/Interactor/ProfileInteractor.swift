//
//  ProfileInteractor.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/21/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

class ProfileInteractor: ProfileInteractorInputProtocol {
    
    weak var presenter: ProfileInteractorOutputProtocol?
    var service: ProfileServiceInputProtocol?
    
    func getUserInfo(user: UserDetailProtocol) {
        service?.getUserInfo(user)
    }
    
}

extension ProfileInteractor: ProfileServiceOutputProtocol {
    
    func onSuccessUserInfo(_ user: UserDetailProtocol) {
        presenter?.onSuccessUserInfo(user)
    }
    
    func onError(_ error: Error?) {
        presenter?.onError(error)
    }
    
}
