//
//  SMBPreferences.swift
//  SMB
//
//  Created by Vinoth on 23/09/20.
//  Copyright © 2020 NOVIS. All rights reserved.
//

import Foundation

class SMBDefaults {
    
    static let userDefaults          = UserDefaults()
    static private let kLoggedIn     = "loggedIn"
    static private let kPhoneNumber  = "phoneNumber"
    static private let kUserName     = "username"
    static private let kAdmin        = "kAdmin"

    class var admin : Bool {
        set {
            userDefaults.set(newValue, forKey: kAdmin)
            userDefaults.synchronize()
        }
        get {
            return userDefaults.bool(forKey: kAdmin)
        }
    }
    class var loggedIn : Bool {
        set {
            userDefaults.set(newValue, forKey: kLoggedIn)
            userDefaults.synchronize()
        }
        get {
            return userDefaults.bool(forKey: kLoggedIn)
        }
    }
    class var phoneNumber : String {
        set {
            userDefaults.set(newValue, forKey: kPhoneNumber)
            userDefaults.synchronize()
        }
        get {
            return userDefaults.string(forKey: kPhoneNumber) ?? ""
        }
    }
    class var userName : String {
        set {
            userDefaults.set(newValue, forKey: kUserName)
            userDefaults.synchronize()
        }
        get {
            return userDefaults.string(forKey: kUserName) ?? ""
        }
    }
}
