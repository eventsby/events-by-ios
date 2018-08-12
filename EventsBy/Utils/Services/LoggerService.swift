//
//  LoggerService.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 8/12/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import EXPLogger

class LoggerService: NSObject {
    
    static let shared = LoggerService()
    static let log = LoggerService().logger
    
    private let logger = EXPLogger.self
    
    // MARK: Init
    
    func initialize() {
        let console = ConsoleTarget()
        console.minLogLevel = .verbose
        logger.addTarget(console)
    }
    
}
