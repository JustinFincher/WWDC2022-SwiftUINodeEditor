//
//  SetValueNode.swift
//  ScriptNode
//
//  Created by fincher on 4/21/22.
//

import SwiftUI
import Foundation

class SetValueNode : NodeData {
    
    class override func getDefaultTitle() -> String {
        "SetValue"
    }
    
    override func perform() {
        
    }
    
    override class func getDefaultDataInPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, name: "Target", direction: .input),
            NodeDataPortData(portID: 1, name: "Value", direction: .input)
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
    
    override class func getDefaultCustomRendering(node: NodeData) -> AnyView? {
        AnyView(
            VStack {
                Text("\(node.inDataPorts[safe: 0]?.nodePortValue.debugDescription ?? "nil")")
            }.frame(minWidth: 100, maxWidth: 200, alignment: .center)
                .font(.body.monospaced())
        )
    }
}
