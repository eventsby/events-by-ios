//
//  OAuth2Handler.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/11/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Alamofire

class OAuth2Handler {
    
    fileprivate weak var sessionManager: SessionManager?
    
    fileprivate typealias RefreshCompletion = (_ succeeded: Bool, _ accessToken: String?, _ refreshToken: String?) -> Void
    fileprivate let lock = NSLock()
    fileprivate var isRefreshing = false
    fileprivate var requestsToRetry: [RequestRetryCompletion] = []
    
    // MARK: - Initialization
    
    public init(_ sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    // MARK: - Private - Refresh Tokens
    
    private func refreshTokens(completion: @escaping RefreshCompletion) {
        guard !isRefreshing else { return }
        isRefreshing = true
        
        let url = AuthEndpoint.refreshToken.url
        
        let params: [String: String] = [
            NetworkConstants.grantType: NetworkConstants.refreshToken,
            NetworkConstants.clientId: NetworkConstants.clientIdValue,
            NetworkConstants.refreshToken: PreferenceManager.shared.refreshToken
        ]
        
        Swift.print(params)
        
        sessionManager?.request(url, method: .post, parameters: params)
            .responseJSON { [weak self] response in
                guard let strongSelf = self else { return }
                if
                    let json = response.result.value as? [String: Any],
                    let accessToken = json["access_token"] as? String,
                    let refreshToken = json["refresh_token"] as? String
                {
                    PreferenceManager.shared.token = accessToken
                    PreferenceManager.shared.refreshToken = refreshToken
                    completion(true, accessToken, refreshToken)
                } else {
                    completion(false, nil, nil)
                }
                strongSelf.isRefreshing = false
        }
    }
    
}

extension OAuth2Handler: RequestAdapter {
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        guard let requestUrl = urlRequest.url else { return urlRequest }
        if requestUrl.absoluteString.contains(NetworkConstants.authTokenUrl) {
            urlRequest.setValue(NetworkConstants.authorizationValue, forHTTPHeaderField: NetworkConstants.headerAuthorization)
        } else {
            let token = PreferenceManager.shared.token
            guard !token.isEmpty else { return urlRequest }
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: NetworkConstants.headerAuthorization)
        }
        return urlRequest
    }
    
}

extension OAuth2Handler: RequestRetrier {
    
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        lock.lock() ; defer { lock.unlock() }
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            requestsToRetry.append(completion)
            
            if !isRefreshing {
                refreshTokens { [weak self] succeeded, accessToken, refreshToken in
                    guard let strongSelf = self else { return }
                    strongSelf.lock.lock() ; defer { strongSelf.lock.unlock() }
                    strongSelf.requestsToRetry.forEach { $0(succeeded, 0.0) }
                    strongSelf.requestsToRetry.removeAll()
                }
            }
        } else {
            completion(false, 0.0)
        }
    }
    
}
