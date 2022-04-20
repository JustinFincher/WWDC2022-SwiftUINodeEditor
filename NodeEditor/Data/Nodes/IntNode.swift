//
//  IntNode.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/19/22.
//

import Foundation

class IntNode : NodeData {
    
    override func getDefaultTitle() -> String {
        "Int"
    }
    
    override func getDefaultOutPorts() -> [NodePortData] {
        return [
            NodePortData(portID: 0, name: "Result", direction: .output)
        ]
    }
}
