//
//  IntNode.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/19/22.
//

import Foundation

class IntNode : NodeData {
    
    
    class override func getDefaultTitle() -> String {
        "Int"
    }
    
    class override func getDefaultDataOutPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, name: "Result", direction: .output)
        ]
    }
}
