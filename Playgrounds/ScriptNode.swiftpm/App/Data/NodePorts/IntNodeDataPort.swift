//
//  IntNodeDataPort.swift
//  ScriptNode
//
//  Created by fincher on 4/23/22.
//

import Foundation

class IntNodeDataPort: NodeDataPortData {
    override class func getDefaultValue() -> Any? {
        return 0
    }
    
    override class func getDefaultValueType() -> Any {
        Int.self
    }
}
