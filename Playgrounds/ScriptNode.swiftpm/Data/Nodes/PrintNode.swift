//
//  PrintNode.swift
//  ScriptNode
//
//  Created by fincher on 4/21/22.
//

import Foundation

class PrintNode : NodeData {
    
    
    override func getDefaultTitle() -> String {
        "Print"
    }
    
    override func getDefaultDataInPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, name: "Message", direction: .input)
        ]
    }
    
    override func getDefaultControlInPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .input)
        ]
    }
    
    override func getDefaultControlOutPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .output)
        ]
    }
    
}
