//
//  UserService.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/9/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation
import KeychainAccess

protocol UserServiceProtocol {
    
    func lastUser() -> UserDetailProtocol?
    func saveUser(_ user: UserDetailProtocol)
    
}

final class UserService: UserServiceProtocol {
    
    private struct Keys {
        static let user = "user"
        static let firstTimeInit = "firstTimeInit"
    }
    
    private struct Consts {
        static let keychainService = "by.hrodna.events.user.service"
    }
    
    private let keychain = Keychain(service: Consts.keychainService)
    
    init() {
        resetOnFirstInit()
    }
    
    func lastUser() -> UserDetailProtocol? {
        let user: UserDetail? = getLocalValue(for: Keys.user)
        return user
    }
    
    func saveUser(_ user: UserDetailProtocol) {
        let user = UserDetail(user)
        saveLocalValue(user, for: Keys.user)
    }
    
}

private extension UserService {
    
    func getLocalValue<T: Decodable>(for key: String) -> T? {
        guard let data = keychain[data: key] else {
            return nil
        }
        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: data)
    }
    
    func saveLocalValue<T: Encodable>(_ value: T, for key: String) {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(value) else {
            return
        }
        keychain[data: key] = data
    }
    
    func resetOnFirstInit() {
        guard UserDefaults.standard.object(forKey: Keys.firstTimeInit) == nil else {
            return
        }
        UserDefaults.standard.set("false", forKey: Keys.firstTimeInit)
        UserDefaults.standard.synchronize()
        keychain[data: Keys.user] = nil
    }
    
}
