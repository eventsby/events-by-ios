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
    
    func requestDetails() -> EndpointType {
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
            return EndpointEntity(url: url, method: .post, params: params)
        case .userInfo:
            var url = "\(NetworkConstants.baseUrl)\(NetworkConstants.version)"
            url.append("users/info")
            return EndpointEntity(url: url, method: .get, params: nil)
        case .refreshToken:
            var url = "\(NetworkConstants.baseUrl)"
            url.append(NetworkConstants.authTokenUrl)
            let params: [String: String] = [
                NetworkConstants.grantType: NetworkConstants.refreshToken,
                NetworkConstants.clientId: NetworkConstants.clientIdValue,
                NetworkConstants.refreshToken: PreferenceManager.shared.refreshToken
            ]
            return EndpointEntity(url: url, method: .post, params: params)
        }
    }
    
}
