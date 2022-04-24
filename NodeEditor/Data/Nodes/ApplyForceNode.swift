//
//  ApplyForceNode.swift
//  ScriptNode
//
//  Created by fincher on 4/23/22.
//

import SwiftUI
import Foundation
import SpriteKit

class ApplyForceNode : NodeData {
    
    override class func getDefaultCategory() -> String {
        "Operator"
    }
    
    class override func getDefaultTitle() -> String {
        "Apply Force"
    }
    
    override func perform() {
        guard let inDataPort1 = self.inDataPorts[safe: 0],
           let inDataPort2 = self.inDataPorts[safe: 1],
        let outControlPort1 = self.outControlPorts[safe: 0] else {
            return
        }
        if let spriteNode = inDataPort1.value as? SKSpriteNode, let vector = inDataPort2.value as? CGVector {
            print("applyImpulse")
            spriteNode.physicsBody?.applyImpulse(vector)
        }

        outControlPort1.connections[safe: 0]?.endPort?.nodeData?.perform()
    }
    
    override class func getDefaultDataInPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, name: "Object", direction: .input),
            NodeDataPortData(portID: 1, name: "Vector", direction: .input)
        ]
    }
    
    override class func getDefaultControlInPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .input)
        ]
    }
    
    override class func getDefaultControlOutPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .output)
        ]
    }
}

