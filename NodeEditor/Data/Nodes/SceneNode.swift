//
//  SceneNode.swift
//  ScriptNode
//
//  Created by fincher on 4/22/22.
//

import Foundation

class SceneNode : NodeData {
    
    class override func getDefaultTitle() -> String {
        "Create Scene"
    }
    override class func getDefaultDataInPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, name: "Camera", direction: .input),
            NodeDataPortData(portID: 1, name: "Children", direction: .input)
        ]
    }
    
    override class func getDefaultDataOutPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, name: "Scene", direction: .output),
        ]
    }
    
    class override func getDefaultControlOutPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .output)
        ]
    }
    
    override class func getDefaultControlInPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .input)
        ]
    }
}
