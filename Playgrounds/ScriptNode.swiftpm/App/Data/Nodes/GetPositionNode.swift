//
//  GetPositionNode.swift
//  ScriptNode
//
//  Created by fincher on 4/24/22.
//

import Foundation
import SpriteKit

class GetPositionNode : NodeData {
    
    override class func getDefaultCategory() -> String {
        "Operator"
    }
    
    class override func getDefaultTitle() -> String {
        "Get Position 📍"
    }
    
    override class func getDefaultPerformImplementation() -> ((NodeData) -> ()) {
        return { nodeData in
            if let port1 = nodeData.inDataPorts[safe: 0] as? SKNodeNodeDataPort,
               let port1Node = port1.value as? SKNode,
               let port2 = nodeData.outDataPorts[safe: 0] as? CGFloatNodeDataPort,
               let port3 = nodeData.outDataPorts[safe: 1] as? CGFloatNodeDataPort
            {
                port2.value = port1Node.position.x
                port3.value = port1Node.position.y
//                print("port2.value = port1Node.position.x \(port1Node.position.x)")
//                print("port3.value = port1Node.position.y \(port1Node.position.y)")
            }
            nodeData.outControlPorts[safe: 0]?.connections[safe: 0]?.endPort?.nodeData?.perform()
        }
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
    
    override class func getDefaultDataInPorts() -> [NodeDataPortData] {
        return [
            SKNodeNodeDataPort(portID: 0, name: "Object", direction: .input)
        ]
    }
    
    class override func getDefaultDataOutPorts() -> [NodeDataPortData] {
        return [
            CGFloatNodeDataPort(portID: 0, name: "X", direction: .output),
            CGFloatNodeDataPort(portID: 0, name: "Y", direction: .output)
        ]
    }
    
}
