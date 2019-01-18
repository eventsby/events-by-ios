//
//  Session.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 1/18/19.
//  Copyright © 2019 Events-By. All rights reserved.
//

import UIKit
import Swinject

protocol SessionType {
    func resolve<T>() -> T
}

final class Session: SessionType {
    
    private let container = Container()
    
    init() {
        container.register(NetworkManagerProtocol.self) { resolver -> NetworkManagerProtocol in
            guard let userService = resolver.resolve(UserServiceProtocol.self) else {
                fatalError("user service is not registered")
            }
            return NetworkManager(userService: userService)
        }.inObjectScope(.container)
        
        container.register(UserServiceProtocol.self) { _ -> UserServiceProtocol in
            return UserService()
        }.inObjectScope(.container)
        
        container.register(EventListServiceProtocol.self) { resolver -> EventListServiceProtocol in
            guard let networkManager = resolver.resolve(NetworkManagerProtocol.self) else {
                fatalError("NetworkManager is not registered")
            }
            return EventListService(networkManager)
        }.inObjectScope(.container)
    }
    
    func resolve<T>() -> T {
        guard let service = container.resolve(T.self) else {
            fatalError("Service is not registered '\(String(describing: T.self))'")
        }
        return service
    }
    
}
