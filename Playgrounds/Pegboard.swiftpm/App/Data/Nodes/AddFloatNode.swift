//
//  AddNode.swift
//  ScriptNode
//
//  Created by fincher on 4/24/22.
//

import Foundation
import SpriteKit
import SwiftUI

class AddFloatNode : NodeData {
    
    override class func getDefaultCategory() -> String {
        "Operator"
    }
    
    class override func getDefaultTitle() -> String {
        "Add Float ➕"
    }
    
    override class func getDefaultPerformImplementation() -> ((NodeData) -> ()) {
        return { nodeData in
            if let nodeData = nodeData as? AddFloatNode,
                let port1 = nodeData.inDataPorts[safe: 0] as? CGFloatNodeDataPort,
               let port1Float = port1.value as? CGFloat
            {
                port1.value = CGFloat(port1Float + nodeData.addition)
            }
            nodeData.outControlPorts[safe: 0]?.connections[safe: 0]?.endPort?.nodeData?.perform()
        }
    }
    
    override class func getDefaultControlInPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .input)
        ]
    }
    
    override class func getDefaultControlOutPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .output)
        ]
    }
    
    override class func getDefaultDataInPorts() -> [NodeDataPortData] {
        return [
            CGFloatNodeDataPort(portID: 0, name: "Value", direction: .input)
        ]
    }
    
    var addition : CGFloat = 0
    
    override class func getDefaultCustomRendering(node: NodeData) -> AnyView? {
        return AnyView (
            HStack {
                Text("Add")
                TextField("Add", value: .init(get: { () -> CGFloat in
                    if let node = node as? AddFloatNode {
                        return node.addition
                    } else { return CGFloat(0) }
                }, set: { newValue in
                    if let node = node as? AddFloatNode {
                        node.addition = newValue
                    }
                }), formatter: NumberFormatter(), prompt: Text("Add"))
                .textFieldStyle(.roundedBorder)
            }
            .font(.caption.monospaced())
            .frame(minWidth: 100, maxWidth: 180, alignment: .center)
        )
    }
}
