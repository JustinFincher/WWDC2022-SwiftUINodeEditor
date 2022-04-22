//
//  SetValueNode.swift
//  ScriptNode
//
//  Created by fincher on 4/21/22.
//

import Foundation

class SetValueNode : NodeData {
    
    class override func getDefaultTitle() -> String {
        "SetValue"
    }
    override class func getDefaultDataInPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, name: "Variable", direction: .input),
            NodeDataPortData(portID: 1, name: "Value", direction: .input)
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
