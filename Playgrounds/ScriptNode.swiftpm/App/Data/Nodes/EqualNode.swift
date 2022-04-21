//
//  EqualNode.swift
//  ScriptNode
//
//  Created by fincher on 4/21/22.
//

import Foundation
class EqualNode : NodeData {
    
    
    override func getDefaultTitle() -> String {
        "Equal"
    }
    
    override func getDefaultDataInPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, name: "First", direction: .input),
            NodeDataPortData(portID: 0, name: "Second", direction: .input)
        ]
    }
    override func getDefaultDataOutPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, name: "Comparison", direction: .output)
        ]
    }
}
