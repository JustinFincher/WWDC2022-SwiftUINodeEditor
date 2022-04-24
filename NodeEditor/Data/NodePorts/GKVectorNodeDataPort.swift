//
//  GKVectorNodeDataPort.swift
//  ScriptNode
//
//  Created by fincher on 4/24/22.
//

import Foundation
import SpriteKit


class GKVectorNodeDataPort: NodeDataPortData {
    
    override class func getDefaultValue() -> Any? {
        return CGVector.zero
    }
    
    override class func getDefaultValueType() -> Any.Type {
        CGVector.self
    }
}
