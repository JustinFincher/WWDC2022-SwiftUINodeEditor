//
//  IfNode.swift
//  ScriptNode
//
//  Created by fincher on 4/21/22.
//

import Foundation

class IfNode : NodeData {
    
    
    override func getDefaultTitle() -> String {
        "If"
    }
    
    override func getDefaultDataInPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, name: "Condition", direction: .input)
        ]
    }
    
    override func getDefaultControlInPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .input)
        ]
    }
    
    override func getDefaultControlOutPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "True", direction: .output),
            NodeControlPortData(portID: 1, name: "False", direction: .output)
        ]
    }
    
}
