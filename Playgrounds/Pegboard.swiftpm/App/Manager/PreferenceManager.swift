//
//  PreferenceManager.swift
//  ScriptNode
//
//  Created by fincher on 4/20/22.
//

import Foundation

class PreferenceManager : BaseManager {
    
    static let instance = PreferenceManager()
    
    override class var shared: PreferenceManager {
        return instance
    }
    
    let userDefaults : UserDefaults = UserDefaults.standard
    
    override func setup() {
        
    }
    
    override func destroy() {
        
    }
}
