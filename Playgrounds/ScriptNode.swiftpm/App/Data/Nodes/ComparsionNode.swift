//
//  ComparsionNode.swift
//  ScriptNode
//
//  Created by fincher on 4/24/22.
//

import Foundation


class ComparsionNode : NodeData {
    
    override class func getDefaultCategory() -> String {
        "Operator"
    }
    
    class override func getDefaultTitle() -> String {
        "Comparsion ⚖️"
    }
    
    class override func getDefaultDataOutPorts() -> [NodeDataPortData] {
        return [
            CGVectorNodeDataPort(portID: 0, name: "Result", direction: .output)
        ]
    }
    
}
