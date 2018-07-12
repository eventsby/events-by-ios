//
//  OAuth2Handler.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/11/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Alamofire

class OAuth2Handler: RequestAdapter {
    
    fileprivate weak var sessionManager: SessionManager?
    
    // MARK: - Initialization
    
    public init(_ sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    // MARK: - RequestAdapter
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        if (urlRequest.url?.absoluteString.contains(NetworkConstants.authTokenUrl))! {
            urlRequest.setValue(NetworkConstants.authorizationValue, forHTTPHeaderField: NetworkConstants.headerAuthorization)
        } else {
            let token = "e2d20c25-1d9b-438c-8925-022780100079" // TODO
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: NetworkConstants.headerAuthorization)
        }
        return urlRequest
    }
    
}
