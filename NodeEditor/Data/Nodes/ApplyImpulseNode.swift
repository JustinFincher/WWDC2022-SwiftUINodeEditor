//
//  ApplyForceNode.swift
//  ScriptNode
//
//  Created by fincher on 4/23/22.
//

import SwiftUI
import Foundation
import SpriteKit

class ApplyImpulseNode : NodeData {
    
    override class func getDefaultCategory() -> String {
        "Physics"
    }
    
    class override func getDefaultTitle() -> String {
        "Apply Force"
    }
    
    override class func getDefaultPerformImplementation() -> ((NodeData) -> ()) {
        return { nodeData in
            guard let inDataPort1 = nodeData.inDataPorts[safe: 0],
               let inDataPort2 = nodeData.inDataPorts[safe: 1],
            let outControlPort1 = nodeData.outControlPorts[safe: 0] else {
                return
            }
            if let spriteNode = inDataPort1.value as? SKSpriteNode, let vector = inDataPort2.value as? CGVector {
                print("applyImpulse")
                spriteNode.physicsBody?.applyImpulse(vector)
            }

            outControlPort1.connections[safe: 0]?.endPort?.nodeData?.perform()
        }
    }
    
    override class func getDefaultDataInPorts() -> [NodeDataPortData] {
        return [
            SKSpriteNodeNodeDataPort(portID: 0, name: "Object", direction: .input),
            GKVectorNodeDataPort(portID: 1, name: "Vector", direction: .input)
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

