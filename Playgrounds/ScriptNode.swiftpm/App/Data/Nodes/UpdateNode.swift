//
//  UpdateNode.swift
//  ScriptNode
//
//  Created by fincher on 4/21/22.
//

import Foundation

class UpdateNode : NodeData {
    
    class override func getDefaultExposedToUser() -> Bool {
        false
    }
    
    class override func getDefaultTitle() -> String {
        "Update"
    }
    
    class override func getDefaultControlOutPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .output)
        ]
    }
}
