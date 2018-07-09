//
//  LoginService.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/9/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation
import Alamofire

protocol LoginServiceInputProtocol: class {
    var remoteRequestHandler: LoginServiceOutputProtocol? { get set }
    
    func login(login: String, password: String)
    func getUserInfo(token: TokenProtocol)
}

protocol LoginServiceOutputProtocol: class {
    func onSuccessLogin(_ user: UserDetailProtocol)
    func onInvalidCredentials()
    func onError(_ error: Error?)
}

class LoginService: LoginServiceInputProtocol {
    
    var remoteRequestHandler: LoginServiceOutputProtocol?
    
    let sessionManager = NetworkManager.shared.sessionManager
    
    func login(login: String, password: String) {
        sessionManager
            .request(Endpoints.Auth.token.url, method: .get)
            .validate()
            .responseJSON { response in
                if response.result.error == nil, let data = response.data {
                    if let token = try? JSONDecoder().decode(TokenModel.self, from: data) {
                        self.getUserInfo(token: token)
                    }
                    self.remoteRequestHandler?.onInvalidCredentials()
                } else {
                    self.remoteRequestHandler?.onError(response.result.error)
                }
        }
    }
    
    func getUserInfo(token: TokenProtocol) {
        sessionManager
            .request(Endpoints.Auth.userInfo.url, method: .get)
            .validate()
            .responseJSON { response in
                if response.result.error == nil, let data = response.data {
                    if let user = try? JSONDecoder().decode(UserDetail.self, from: data) {
                        self.remoteRequestHandler?.onSuccessLogin(user)
                    }
                    self.remoteRequestHandler?.onInvalidCredentials()
                } else {
                    self.remoteRequestHandler?.onError(response.result.error)
                }
        }
    }
    
}
