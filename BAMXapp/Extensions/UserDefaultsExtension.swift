//
//  UserDefaultsExtension.swift
//  BAMXapp
//
//  Created by user195828 on 9/7/21.
//

import Foundation

extension UserDefaults {
    private enum UserDefaultKeys: String {
        case hasOnboarded
    }
    
    var hasOnboarded: Bool {
        get {
            bool(forKey: UserDefaultKeys.hasOnboarded.rawValue)
        }
        
        set {
            setValue(newValue, forKey: UserDefaultKeys.hasOnboarded.rawValue)
        }
    }
}
