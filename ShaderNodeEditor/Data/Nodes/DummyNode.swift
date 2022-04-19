//
//  DummyNode.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/19/22.
//

import Foundation

class DummyNode : NodeData {
    
    override func getDefaultTitle() -> String {
        "Dummy"
    }
    
    override func getDefaultOutPorts() -> [NodePortData] {
        return [
            NodePortData(portID: 0, name: "Output 1"),
            NodePortData(portID: 0, name: "Output 2")
        ]
    }
    
    override func getDefaultInPorts() -> [NodePortData] {
        return [
            NodePortData(portID: 0, name: "Input")
        ]
    }
}
