//
//  NetworkManager.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Alamofire

class NetworkManager: NSObject {

    static let shared = NetworkManager()

    public var sessionManager: SessionManager

    private override init() {
        let configuration: URLSessionConfiguration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 40
        configuration.timeoutIntervalForResource = 40
        sessionManager = SessionManager(configuration: configuration)
        let handler = OAuth2Handler(sessionManager)
        sessionManager.adapter = handler
    }

}
