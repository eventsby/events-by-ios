//
//  NetworkConstaints.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/11/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

class NetworkConstants {
    static let version = "api/v1/"
    static let baseUrl = "https://eventsby.herokuapp.com/"
    
    static let authTokenUrl = "oauth/token"
    
    static let grantType = "grant_type"
    static let clientId = "client_id"
    static let clientIdValue = "clientapp"
    static let refreshToken = "refresh_token"
    static let username = "username"
    static let password = "password"
    
    static let headerAuthorization = "Authorization";
    static let authorizationValue = "Basic Y2xpZW50YXBwOjEyMzQ1Ng==";
}
