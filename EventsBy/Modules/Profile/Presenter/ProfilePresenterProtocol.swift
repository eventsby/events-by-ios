//
//  ProfilePresenterProtocol.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/21/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

protocol ProfilePresenterProtocol: class {
    var view: ProfileViewProtocol? { get set }
    var interactor: ProfileInteractorInputProtocol? { get set }
    var router: ProfileRouterProtocol? { get set }
    var userService: UserServiceProtocol? { get set }
    
    var userStatus: UserStatus { get }
    
    // View -> Presenter
    func viewDidLoad()
}
