//
//  SKSpriteNodeNodeDataPort.swift
//  ScriptNode
//
//  Created by fincher on 4/24/22.
//

import Foundation
import SpriteKit

class SKSpriteNodeNodeDataPort: NodeDataPortData {
    override class func getDefaultValue() -> Any? {
        return SKSpriteNode()
    }
    
    override class func getDefaultValueType() -> Any.Type {
        SKSpriteNode.self
    }
}
