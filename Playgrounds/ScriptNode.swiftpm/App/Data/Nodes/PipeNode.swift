//
//  PipeNode.swift
//  ScriptNode
//
//  Created by fincher on 4/24/22.
//

import Foundation

import Foundation

class PipeNode : NodeData {
    
    override class func getDefaultCategory() -> String {
        "Actor"
    }
    
    class override func getDefaultTitle() -> String {
        "Pipe 🏙"
    }
    
    override class func getDefaultDataOutPorts() -> [NodeDataPortData] {
        return [
            SKNodeNodeDataPort(portID: 0, direction: .output, name: "", defaultValueGetter: {
                return PageManager.shared.nodePageData.pipe
            }, defaultValueSetter: { _ in })
        ]
    }
}
