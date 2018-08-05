//
//  NetworkManager.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Alamofire

class NetworkManager: NSObject {
    
    private struct Constants {
        static let requestTimeout: TimeInterval = 40 // sec
        static let resourceTimeout: TimeInterval = 40 // sec
    }

    static let shared = NetworkManager()

    public var sessionManager: SessionManager

    private override init() {
        let configuration: URLSessionConfiguration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = Constants.requestTimeout
        configuration.timeoutIntervalForResource = Constants.resourceTimeout
        sessionManager = SessionManager(configuration: configuration)
        let handler = OAuth2Handler(sessionManager)
        sessionManager.adapter = handler
        sessionManager.retrier = handler
    }

}
