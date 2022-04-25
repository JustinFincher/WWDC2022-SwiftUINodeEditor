//
//  CGFloatNodeDataPort.swift
//  ScriptNode
//
//  Created by fincher on 4/24/22.
//

import Foundation
import CoreGraphics

class CGFloatNodeDataPort: NodeDataPortData {
    override class func getDefaultValue() -> Any? {
        return CGFloat(0.0)
    }
    
    override class func getDefaultValueType() -> Any.Type {
        CGFloat.self
    }
}
