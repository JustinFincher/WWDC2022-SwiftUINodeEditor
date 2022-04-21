//
//  PrintNode.swift
//  ScriptNode
//
//  Created by fincher on 4/21/22.
//

import Foundation

class PrintNode : NodeData {
    
    
    class override func getDefaultTitle() -> String {
        "Print"
    }
    
    class override func getDefaultDataInPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, name: "Message", direction: .input)
        ]
    }
    
    class override func getDefaultControlInPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .input)
        ]
    }
    
    class override func getDefaultControlOutPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .output)
        ]
    }
    
}
