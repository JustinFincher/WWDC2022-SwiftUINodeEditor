//
//  EnvironmentManager.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/17/22.
//

import Foundation

class EnvironmentManager : BaseManager {
    
    static let instance = EnvironmentManager()
    
    override class var shared: EnvironmentManager {
        return instance
    }
    
    let environment : Environment = Environment()
    
    override func setup() {
        
    }
    
    override func destroy() {
        
    }
}
