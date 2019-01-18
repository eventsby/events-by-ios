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
    
    private let networkManager: NetworkManagerProtocol
    
    init(_ networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func login(login: String, password: String) {
        let endpoint = AuthEndpoint.token(login: login, password: password)
        
        networkManager
            .sessionManager
            .request(endpoint.url, method: endpoint.method, parameters: endpoint.parameters)
            .validate(statusCode: 200..<402)
            .responseJSON { response in
                if response.result.error == nil, let data = response.data {
                    if let res = response.result.value as? [String: Any], let error = res["error_description"] as? String, error == ServerResponseError.badCredentials.raw() {
                        self.remoteRequestHandler?.onInvalidCredentials()
                        return
                    }
                    guard let token = try? JSONDecoder().decode(TokenModel.self, from: data) else {
                        self.remoteRequestHandler?.onError(ParseError.invalidFormat)
                        return
                    }
                    self.saveToken(token)
                    self.getUserInfo(token: token)
                } else {
                    self.remoteRequestHandler?.onError(GenericError.unexpectedError(nil))
                }
        }
    }
    
    func getUserInfo(token: TokenProtocol) {
        let endpoint = AuthEndpoint.userInfo
        
        networkManager
            .sessionManager
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
    
    private func saveToken(_ token: TokenProtocol) {
        PreferenceManager.shared.token = token.accessToken
        PreferenceManager.shared.refreshToken = token.refreshToken
    }
    
}
