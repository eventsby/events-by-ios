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
        let endpoint = AuthEndpoint.token(login: login, password: password)
        
        sessionManager
            .request(endpoint.url, method: endpoint.method, parameters: endpoint.parameters)
            .validate()
            .responseJSON { response in
                if response.result.error == nil, let data = response.data {
                    guard let token = try? JSONDecoder().decode(TokenModel.self, from: data) else {
                        self.remoteRequestHandler?.onInvalidCredentials()
                        return
                    }
                    self.getUserInfo(token: token)
                } else {
                    self.remoteRequestHandler?.onError(response.result.error)
                }
        }
    }
    
    func getUserInfo(token: TokenProtocol) {
        let endpoint = AuthEndpoint.userInfo
        
        sessionManager
            .request(endpoint.url, method: endpoint.method)
            .validate()
            .responseJSON { response in
                if response.result.error == nil, let data = response.data {
                    guard let user = try? JSONDecoder().decode(UserDetail.self, from: data) else {
                        self.remoteRequestHandler?.onInvalidCredentials()
                        return
                    }
                    self.remoteRequestHandler?.onSuccessLogin(user)
                } else {
                    self.remoteRequestHandler?.onError(response.result.error)
                }
        }
    }
    
}
