//
//  IfNode.swift
//  ScriptNode
//
//  Created by fincher on 4/21/22.
//

import Foundation

class IfNode : NodeData {
    
    
    class override func getDefaultTitle() -> String {
        "If"
    }
    
    class override func getDefaultDataInPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, name: "Condition", direction: .input)
        ]
    }
    
    class override func getDefaultControlInPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .input)
        ]
    }
    
    class override func getDefaultControlOutPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .output),
            NodeControlPortData(portID: 1, name: "True", direction: .output),
            NodeControlPortData(portID: 2, name: "False", direction: .output)
        ]
    }
    
}
