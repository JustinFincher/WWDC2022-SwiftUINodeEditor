//
//  GetTimeNode.swift
//  ScriptNode
//
//  Created by fincher on 4/22/22.
//

import Foundation


class GetTimeNode : NodeData {
    
    class override func getDefaultTitle() -> String {
        "Get Current Time"
    }
    
    override class func getDefaultPerformImplementation() -> ((NodeData) -> ()) {
        return { nodeData in
            nodeData.outDataPorts[0].nodePortValue = Date.now
        }
    }
    
    override class func getDefaultDataOutPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, name: "Time", direction: .output),
        ]
    }
    
    class override func getDefaultControlOutPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .output)
        ]
    }
    
    override class func getDefaultControlInPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .input)
        ]
    }
}
