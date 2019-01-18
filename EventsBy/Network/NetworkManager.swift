//
//  NetworkManager.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Alamofire

protocol NetworkManagerProtocol {
    var sessionManager: SessionManager { get }
}

final class NetworkManager: NetworkManagerProtocol {
    
    private struct Constants {
        static let requestTimeout: TimeInterval = 40 // sec
        static let resourceTimeout: TimeInterval = 40 // sec
    }
    
    private(set) var sessionManager = SessionManager()
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol) {
        self.userService = userService
        
        let configuration: URLSessionConfiguration = .default
        configuration.timeoutIntervalForRequest = Constants.requestTimeout
        configuration.timeoutIntervalForResource = Constants.resourceTimeout
        sessionManager = SessionManager(configuration: configuration)
        let handler = OAuth2Handler(sessionManager)
        sessionManager.adapter = handler
        sessionManager.retrier = handler
    }
    
}
