//
//  BoolNode.swift
//  ScriptNode
//
//  Created by fincher on 4/22/22.
//

import SwiftUI
import Foundation

class BooleanContainer {
    
}

class BoolNode : NodeData {
    
    override class func getDefaultCategory() -> String {
        "Variable"
    }
    
    class override func getDefaultTitle() -> String {
        "Boolean"
    }
    
    override class func getDefaultDataOutPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, name: "Value", direction: .output)
        ]
    }
    
    override class func getDefaultCustomRendering(node: NodeData) -> AnyView? {
        AnyView(
            ZStack {
                Toggle("Value", isOn: .init(get: {
                    if let boolean = node.outDataPorts[safe: 0]?.value as? Bool {
                        return boolean
                    } else {
                        return false
                    }
                }, set: { newValue in
                    node.outDataPorts[safe: 0]?.value = newValue
                }))
                .font(.body.monospaced())
            }.frame(minWidth: 80, maxWidth: 120, alignment: .center)
        )
    }
}
