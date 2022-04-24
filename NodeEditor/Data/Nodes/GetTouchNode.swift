//
//  GetTouchNode.swift
//  ScriptNode
//
//  Created by fincher on 4/23/22.
//

import Foundation

class GetTouchNode : NodeData {
    
    override class func getDefaultCategory() -> String {
        "Event"
    }
    
    class override func getDefaultTitle() -> String {
        "Get Touch"
    }
    
    override class func getDefaultControlOutPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .output)
        ]
    }
}
