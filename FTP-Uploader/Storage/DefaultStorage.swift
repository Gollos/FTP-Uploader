//
//  DefaultStorage.swift
//  FTP-Uploader
//
//  Created by Golos on 3/10/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import Foundation

protocol Defaults {
    func string(forKey defaultName: String) -> String?
    func object(forKey defaultName: String) -> Any?
    
    func set(_ value: Any?, forKey defaultName: String)
    
    @discardableResult func synchronize() -> Bool
}

// MARK: Defaults
extension UserDefaults: Defaults {}

protocol DefaultStorageProtocol {
    var storedState: StorageState? { get }
    
    func store(state: StorageState)
}

struct DefaultStorage {
    
    enum Keys: String {
        case token
        case lifetime
        case cookie
    }
    
    private let defaultStorage: Defaults
    
    init(defaultStorage: Defaults) {
        self.defaultStorage = defaultStorage
    }
}

// MARK: DefaultStorageProtocol
extension DefaultStorage: DefaultStorageProtocol {
    
    var storedState: StorageState? {
        guard let token = defaultStorage.string(forKey: Keys.token.rawValue),
            let lifetime = defaultStorage.string(forKey: Keys.lifetime.rawValue),
            let properties = defaultStorage.object(forKey: Keys.cookie.rawValue) as? [HTTPCookiePropertyKey: Any] else { return nil }
        
        return StorageState(token: token, lifetime: lifetime, cookie: HTTPCookie(properties: properties))
    }
    
    func store(state: StorageState) {
        defaultStorage.set(state.token, forKey: Keys.token.rawValue)
        defaultStorage.set(state.lifetime, forKey: Keys.lifetime.rawValue)
        defaultStorage.set(state.cookie?.properties, forKey: Keys.cookie.rawValue)
        
        defaultStorage.synchronize()
    }
}
