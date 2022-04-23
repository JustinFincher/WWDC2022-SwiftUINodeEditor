//
//  EqualNode.swift
//  ScriptNode
//
//  Created by fincher on 4/21/22.
//

import Foundation
class EqualNode : NodeData {
    
    override class func getDefaultCategory() -> String {
        "Operator"
    }
    
    class override func getDefaultTitle() -> String {
        "Equal"
    }
    
    class override func getDefaultDataInPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, name: "First", direction: .input),
            NodeDataPortData(portID: 0, name: "Second", direction: .input)
        ]
    }
    class override func getDefaultDataOutPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, name: "Comparison", direction: .output)
        ]
    }
}
