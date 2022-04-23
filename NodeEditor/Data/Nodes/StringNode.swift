//
//  StringNode.swift
//  ScriptNode
//
//  Created by fincher on 4/22/22.
//

import SwiftUI
import Foundation

class StringNode : NodeData {
    
    override class func getDefaultCategory() -> String {
        "Variable"
    }
    
    class override func getDefaultTitle() -> String {
        "String"
    }
    
    override class func getDefaultDataOutPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, name: "Value", direction: .output)
        ]
    }
    
    override class func getDefaultCustomRendering(node: NodeData) -> AnyView? {
        AnyView(
            ZStack {
                TextField("Value", text: .init(get: {
                    if let string = node.outDataPorts[0].value as? String {
                        return string
                    } else {
                        return ""
                    }
                }, set: { newString in
                    node.outDataPorts[0].value = newString
                }))
                .lineLimit(nil)
                .font(.body.monospaced())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .contentShape(Rectangle())
            }.frame(minWidth: 80, maxWidth: 120, alignment: .center)
        )
    }
}
