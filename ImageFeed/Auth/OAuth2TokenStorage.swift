//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Никита Федоров on 30.06.2026.
//

import Foundation

final class OAuth2TokenStorage {
    private enum Keys {
        static let token = "token"
    }
    
    var token: String? {
        get {
            UserDefaults.standard.string(forKey: Keys.token)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.token)
        }
    }
}
