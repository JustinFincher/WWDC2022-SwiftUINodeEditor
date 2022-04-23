//
//  WhileNode.swift
//  ScriptNode
//
//  Created by fincher on 4/22/22.
//

import Foundation

class WhileNode : NodeData {
    
    override class func getDefaultCategory() -> String {
        "Control Flow"
    }
    
    class override func getDefaultTitle() -> String {
        "While"
    }
    
    class func getEvalRes(nodeData : NodeData) -> Bool {
        if let value = nodeData.inDataPorts[safe: 0]?.value as? Bool {
            return value == true
        } else {
            return false
        }
    }
    
    override class func getDefaultPerformImplementation() -> ((NodeData) -> ()) {
        return { nodeData in
            while(getEvalRes(nodeData: nodeData)) {
                print("Node \(nodeData.nodeID) \(nodeData.title) while == true")
                nodeData.outControlPorts[safe: 0]?.connections[safe: 0]?.endPort?.nodeData?.perform()
            }
            print("Node \(nodeData.nodeID) \(nodeData.title) while == false")
            nodeData.outControlPorts[safe: 1]?.connections[safe: 0]?.endPort?.nodeData?.perform()
        }
    }
    
    override class func getDefaultDataInPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, name: "Condition", direction: .input),
        ]
    }
    
    class override func getDefaultControlOutPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "While Met", direction: .output),
            NodeControlPortData(portID: 0, name: "No Longer Met", direction: .output)
        ]
    }
    
    override class func getDefaultControlInPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .input)
        ]
    }
}
