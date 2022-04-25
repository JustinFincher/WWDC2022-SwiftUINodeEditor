//
//  StartNode.swift
//  ScriptNode
//
//  Created by fincher on 4/21/22.
//

import Foundation

class StartNode : NodeData {
    
    class override func getDefaultExposedToUser() -> Bool {
        false
    }
    
    class override func getDefaultTitle() -> String {
        "Start"
    }
    
    class override func getDefaultControlOutPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .output)
        ]
    }
}
