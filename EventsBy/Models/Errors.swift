//
//  Errors.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/2/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation

enum ParseError: Error {
    case invalidFormat
}

enum GenericError: Error {
    case failed(String?)
    case unexpectedError(String?)
}

enum ServerResponseError: String {
    
    case unexpected = "Unexpected error"
    case badCredentials = "Bad credentials"
    
    func raw() -> String {
        switch self {
        case .unexpected: return self.rawValue
        case .badCredentials: return self.rawValue
        }
    }
    
}
