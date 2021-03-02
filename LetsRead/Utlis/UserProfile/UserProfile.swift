//
//  UserProfile.swift
//  Istsharat
//
//  Created by taima on 2/7/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import Foundation

class UserProfile {
    static let shared = UserProfile()
    
    // get userID
    var userID: Int? {
        get {
            return UserDefaults.standard.value(forKey: "userID") as? Int
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "userID")
            UserDefaults.standard.synchronize()
        }
    }
    
    // get Aabic name
    var ar_name: String? {
        get {
            return UserDefaults.standard.value(forKey: "ar_name") as? String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "ar_name")
            UserDefaults.standard.synchronize()
        }
    }
    
    // get name
    var name: String? {
        get {
            return UserDefaults.standard.value(forKey: "name") as? String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "name")
            UserDefaults.standard.synchronize()
        }
    }
    
    // get email
    var email: String? {
        get {
            return UserDefaults.standard.value(forKey: "email") as? String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "email")
            UserDefaults.standard.synchronize()
        }
    }
    
    // get Phone number from user
    var mobileNumber: String? {
        get {
            return UserDefaults.standard.value(forKey: "mobileNumber") as? String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "mobileNumber")
            UserDefaults.standard.synchronize()
        }
    }
    
    // get cityID
    var cityID: Int? {
        get {
            return UserDefaults.standard.value(forKey: "cityID") as? Int
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "cityID")
            UserDefaults.standard.synchronize()
        }
    }
    
    // get userType
    var userType: Int? {
        get {
            return UserDefaults.standard.value(forKey: "userType") as? Int
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "userType")
            UserDefaults.standard.synchronize()
        }
    }
    
    // get userToken
    var userToken: String? {
        get {
            return UserDefaults.standard.value(forKey: "userToken") as? String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "userToken")
            UserDefaults.standard.synchronize()
        }
    }
    
    func isUserLogin() -> Bool {
        return  UserProfile.shared.userID != nil
    }
    
    class func fillUserData(_ id: Int, _ name: String, _ token: String = UserProfile.shared.userToken ?? "") {
        let user = UserProfile.shared
        user.userID = id
        user.name = name
        user.userToken = token
    }
    
    var isFirstTime: Bool? {
        get {
            return UserDefaults.standard.value(forKey: "isFirstTime") as? Bool
            
        }set {
            UserDefaults.standard.setValue(newValue, forKey: "isFirstTime")
        }
    }
}

extension UserDefaults {
    static func resetDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
            UserDefaults.standard.synchronize()
        }
    }
}
