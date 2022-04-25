//
//  SKSpriteNodeNodeDataPort.swift
//  ScriptNode
//
//  Created by fincher on 4/24/22.
//

import Foundation
import SpriteKit

class SKNodeNodeDataPort: NodeDataPortData {
    override class func getDefaultValue() -> Any? {
        return SKNode()
    }
    
    override class func getDefaultValueType() -> Any.Type {
        SKNode.self
    }
}
