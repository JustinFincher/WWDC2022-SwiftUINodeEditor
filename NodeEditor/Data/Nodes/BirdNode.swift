//
//  BirdNode.swift
//  ScriptNode
//
//  Created by fincher on 4/23/22.
//

import Foundation

class BirdNode : NodeData {
    
    class override func getDefaultTitle() -> String {
        "Bird"
    }
    
    override class func getDefaultDataOutPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, direction: .output, name: "",defaultValueGetter: {
                return PageManager.shared.nodePageData.bird
            })
        ]
    }
    
    
    
}
