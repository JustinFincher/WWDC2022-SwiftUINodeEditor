//
//  StartNode.swift
//  ScriptNode
//
//  Created by fincher on 4/21/22.
//

import Foundation

class StartNode : NodeData {
    
    
    override func getDefaultTitle() -> String {
        "Start"
    }
    
    override func getDefaultOutPorts() -> [NodePortData] {
        return [
            NodePortData(portID: 0, name: "Start", direction: .output)
        ]
    }
}
