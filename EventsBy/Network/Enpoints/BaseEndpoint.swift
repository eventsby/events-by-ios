//
//  BaseEndpoint.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/11/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation
import Alamofire

/// Types that conform to this model an API endpoint
protocol BaseEndPoint {
    
    /// Provides all the information required to make the API call
    func requestDetails() -> (url: String, method: HTTPMethod, parameters: [String: Any]?)
    
    var url: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    
}

extension BaseEndPoint {
    
    var url: String { return requestDetails().url }
    var method: HTTPMethod { return requestDetails().method }
    var parameters: [String: Any]? { return requestDetails().parameters }
    
}
