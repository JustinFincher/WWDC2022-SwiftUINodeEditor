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
    
    class override func getDefaultTitle() -> String {
        "Boolean"
    }
    
    override class func getDefaultDataOutPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, name: "Value", direction: .output, defaultValue: false)
        ]
    }
    
    override class func getDefaultCustomRendering(node: NodeData) -> AnyView? {
        AnyView(
            ZStack {
                Toggle("Value", isOn: .init(get: {
                    if let boolean = node.outDataPorts[safe: 0]?.nodePortValue as? Bool {
                        return boolean
                    } else {
                        return false
                    }
                }, set: { newValue in
                    node.outDataPorts[safe: 0]?.nodePortValue = newValue
                }))
                .font(.body.monospaced())
            }.frame(minWidth: 100, maxWidth: 200, alignment: .center)
        )
    }
}
