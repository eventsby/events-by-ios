//
//  ProfileViewProtocol.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/21/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

protocol ProfileViewProtocol: class {
    var presenter: ProfilePresenterProtocol? { get set }
    
    func onSuccessUserInfo(_ user: UserDetailProtocol)
    func showError(_ error: Error?)
    func showLoading()
    func hideLoading()
    
    func setupView()
}
