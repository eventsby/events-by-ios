//
//  ProfileService.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/21/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation
import Alamofire

protocol ProfileServiceInputProtocol: class {
    var remoteRequestHandler: ProfileServiceOutputProtocol? { get set }
    
    func getUserInfo(_ user: UserDetailProtocol)
}

protocol ProfileServiceOutputProtocol: class {
    func onSuccessUserInfo(_ user: UserDetailProtocol)
    func onError(_ error: Error?)
}

class ProfileService: ProfileServiceInputProtocol {
    
    var remoteRequestHandler: ProfileServiceOutputProtocol?
    
    let sessionManager = NetworkManager.shared.sessionManager
    
    func getUserInfo(_ user: UserDetailProtocol) {
        
    }
    
}
