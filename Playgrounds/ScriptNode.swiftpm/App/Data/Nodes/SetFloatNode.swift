//
//  SetFloatNode.swift
//  ScriptNode
//
//  Created by fincher on 4/24/22.
//

import Foundation
import SpriteKit
import SwiftUI

class SetFloatNode : NodeData {
    
    override class func getDefaultCategory() -> String {
        "Operator"
    }
    
    class override func getDefaultTitle() -> String {
        "Set Float 🔗"
    }
    
    override class func getDefaultPerformImplementation() -> ((NodeData) -> ()) {
        return { nodeData in
            if let nodeData = nodeData as? SetFloatNode,
                let port1 = nodeData.inDataPorts[safe: 0] as? CGFloatNodeDataPort,
               let port2 = nodeData.inDataPorts[safe: 1] as? CGFloatNodeDataPort
            {
                port1.value = port2.value
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
            CGFloatNodeDataPort(portID: 0, name: "Reference", direction: .input),
            CGFloatNodeDataPort(portID: 1, name: "New Value", direction: .input)
        ]
    }
    
}

