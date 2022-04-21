//
//  DummyNode.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/19/22.
//

import Foundation

class DummyNode : NodeData {
    
    override func exposedToUser() -> Bool {
        true
    }
    
    override func getDefaultTitle() -> String {
        "Dummy"
    }
    
    override func getDefaultDataOutPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, name: "Output 1", direction: .output),
            NodeDataPortData(portID: 1, name: "Output 2", direction: .output),
            NodeDataPortData(portID: 2, name: "VERY LONG OUTPUT 3", direction: .output)
        ]
    }
    
    override func getDefaultDataInPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, name: "Input", direction: .input)
        ]
    }
}
