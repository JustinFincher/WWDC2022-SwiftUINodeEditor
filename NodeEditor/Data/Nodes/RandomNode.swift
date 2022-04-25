//
//  RandomNode.swift
//  ScriptNode
//
//  Created by fincher on 4/24/22.
//


import Foundation
import SpriteKit

class RandomNode : NodeData {
    
    override class func getDefaultCategory() -> String {
        "Variable"
    }
    
    class override func getDefaultTitle() -> String {
        "Generate Random 🎲"
    }
    
    override class func getDefaultPerformImplementation() -> ((NodeData) -> ()) {
        return { nodeData in
            if let port1 = nodeData.outDataPorts[safe: 0] as? CGFloatNodeDataPort
            {
                port1.value = CGFloat.random(in: -30...30)
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
    
    class override func getDefaultDataOutPorts() -> [NodeDataPortData] {
        return [
            CGFloatNodeDataPort(portID: 0, name: "Random", direction: .output)
        ]
    }
    
}
