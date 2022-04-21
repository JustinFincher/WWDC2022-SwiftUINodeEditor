//
//  UserDefaults+SwiftUI.swift
//  ScriptNode
//
//  Created by fincher on 4/20/22.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    var postSetHandler : ((T,T) -> Void)?

    var wrappedValue: T {
        get {
            PreferenceManager.shared.userDefaults.value(forKey: key) as? T ?? defaultValue
        } set {
            if let postSetHandler = postSetHandler {
                let old = wrappedValue
                PreferenceManager.shared.userDefaults.set(newValue, forKey: key)
                postSetHandler(old, newValue)
            } else {
                PreferenceManager.shared.userDefaults.set(newValue, forKey: key)
            }
        }
    }
}
