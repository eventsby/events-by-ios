//
//  PreferenceManager.swift
//  EventsBy
//
//  Created by Alexander Tereshkov on 7/14/18.
//  Copyright © 2018 Events-By. All rights reserved.
//

import Foundation

fileprivate enum PreferenceKeys: String {
    case firstRun = "key.events.by.firstRun"
    case accessToken = "key.events.by.AccessTokenKey"
    case refreshToken = "key.events.by.RefreshTokenKey"
    case userId = "key.events.by.UserIdKeyPreference"
}

class PreferenceManager: NSObject {
    
    static let shared = PreferenceManager()
    
    // MARK: Init
    
    func initialize() {
        if isFirstRunApp() {
            clear()
        }
    }
    
    var token: String {
        get {
            return UserDefaults.standard.string(forKey: PreferenceKeys.accessToken.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: PreferenceKeys.accessToken.rawValue)
        }
    }
    
    var refreshToken: String {
        get {
            return UserDefaults.standard.string(forKey: PreferenceKeys.refreshToken.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: PreferenceKeys.refreshToken.rawValue)
        }
    }
    
    var userId: Int {
        get {
            return UserDefaults.standard.integer(forKey: PreferenceKeys.userId.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: PreferenceKeys.userId.rawValue)
        }
    }
    
    // MARK: Clear
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: PreferenceKeys.accessToken.rawValue)
        UserDefaults.standard.removeObject(forKey: PreferenceKeys.refreshToken.rawValue)
        UserDefaults.standard.removeObject(forKey: PreferenceKeys.userId.rawValue)
    }
    
    func isFirstRunApp() -> Bool {
        return UserDefaults.standard.string(forKey: PreferenceKeys.firstRun.rawValue) == nil
    }
    
    func isAuthorized() -> Bool {
        return !token.isEmpty
    }
    
}
