//
//  LoginPresenterProtocol.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/9/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import ReactiveSwift

protocol LoginPresenterProtocol: class {
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var router: LoginRouterProtocol? { get set }
    var isModal: Bool { get set }
    
    var login: MutableProperty<String?> { get }
    var password: MutableProperty<String?> { get }
    
    // View -> Presenter
    func viewDidLoad()
    func loginAction()
    func closeAction()
}
