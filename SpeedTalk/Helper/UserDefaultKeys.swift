//
//  UserDefaultKeys.swift
//  SpeedTalk
//
//  Created by User on 03/05/25.
//

import Foundation

class UserDefaultKeys {
    static let shared = UserDefaultKeys()
    private init() {}
    let loginType = "LoginType"
    let GoogleUsers = "GoogleUsers"
    let EmailUsers = "EmailUsers"
    let AppleUsers = "AppleUsers"
    let googleTokenKey = "googleTokenKey"
    let uidKey = "uidKey"
    let appleIDKey = "appleIDKey"
    let hasSavedCredentialsKey = "hasSavedCredentialsKey"
    let hasCompletedOnboarding = "hasCompletedOnboarding"
    let darkModeKey = "darkModeKey"
}

extension UserDefaultKeys{
    func shouldShowLoginScreen() -> Bool {
        if let  hasOnboardingCompleted = UserDefaults.standard.bool(forKey: hasCompletedOnboarding) as? Bool  {
            return !UserDefaults.standard.bool(forKey: hasCompletedOnboarding)
        }else {
            return false
        }
      
    }
}
