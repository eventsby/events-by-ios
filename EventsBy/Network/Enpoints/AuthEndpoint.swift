//
//  AuthEndpoint.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/11/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation
import Alamofire

enum AuthEndpoint: BaseEndPoint {
    
    case userInfo
    case token(login: String, password: String)
    case refreshToken
    
    func requestDetails() -> (url: String, method: HTTPMethod, parameters: [String : Any]?) {
        switch self {
        case .token(let login, let password):
            let params: [String: String] = [
                NetworkConstants.grantType: NetworkConstants.password,
                NetworkConstants.clientId: NetworkConstants.clientIdValue,
                "username": login,
                "password": password
            ]
            var url = "\(NetworkConstants.baseUrl)"
            url.append(NetworkConstants.authTokenUrl)
            return (url: url, method: .post, parameters: params)
        case .userInfo:
            var url = "\(NetworkConstants.baseUrl)\(NetworkConstants.version)"
            url.append("users/info")
            return (url: url, method: .get, parameters: nil)
        case .refreshToken:
            var url = "\(NetworkConstants.baseUrl)"
            url.append(NetworkConstants.refreshToken)
            return (url: url, method: .post, parameters: nil)
        }
    }
    
}
