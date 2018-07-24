//
//  ProfileInteractorProtocol.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/21/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

protocol ProfileInteractorOutputProtocol: class {
    // Interactor -> Presenter
    func onSuccessUserInfo(_ user: UserDetailProtocol)
    func onError(_ error: Error?)
}

protocol ProfileInteractorInputProtocol: class {
    var presenter: ProfileInteractorOutputProtocol? { get set }
    var service: ProfileServiceInputProtocol? { get set }
    
    // Presenter -> Interactor
    func getUserInfo(user: UserDetailProtocol)
}
