//
//  SetPositionNode.swift
//  ScriptNode
//
//  Created by fincher on 4/24/22.
//

import Foundation
import SpriteKit

class SetPositionNode : NodeData {
    
    override class func getDefaultCategory() -> String {
        "Operator"
    }
    
    class override func getDefaultTitle() -> String {
        "Set Position 📍"
    }
    
    override class func getDefaultPerformImplementation() -> ((NodeData) -> ()) {
        return { nodeData in
            if let port1 = nodeData.inDataPorts[safe: 0] as? SKNodeNodeDataPort,
               let port1Node = port1.value as? SKNode,
               let port2 = nodeData.inDataPorts[safe: 1] as? CGFloatNodeDataPort,
               let port3 = nodeData.inDataPorts[safe: 2] as? CGFloatNodeDataPort,
               let port2Value = port2.value as? CGFloat,
               let port3Value = port3.value as? CGFloat
            {
                port1Node.position = .init(x: port2Value, y: port3Value)
//                print("port1Node.position \(port1Node.position ) = (x: \(port2Value), y: \(port3Value))")
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
            SKNodeNodeDataPort(portID: 0, name: "Object", direction: .input),
            CGFloatNodeDataPort(portID: 1, name: "X", direction: .input),
            CGFloatNodeDataPort(portID: 2, name: "Y", direction: .input)
        ]
    }
    
}
