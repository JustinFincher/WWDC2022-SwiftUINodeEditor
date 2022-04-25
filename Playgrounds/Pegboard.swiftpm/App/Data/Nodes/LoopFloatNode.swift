//
//  LoopFloatNode.swift
//  ScriptNode
//
//  Created by fincher on 4/24/22.
//

import Foundation
import SwiftUI
import SpriteKit

class LoopFloatNode : NodeData {
    
    override class func getDefaultCategory() -> String {
        "Operator"
    }
    
    class override func getDefaultTitle() -> String {
        "Loop Float 🔂"
    }
    
    override class func getDefaultPerformImplementation() -> ((NodeData) -> ()) {
        return { nodeData in
            if let nodeData = nodeData as? LoopFloatNode,
               let port1 = nodeData.inDataPorts[safe: 0] as? CGFloatNodeDataPort,
               let port1Float = port1.value as? CGFloat,
               let port2 = nodeData.outDataPorts[safe: 0] as? CGFloatNodeDataPort
            {
                if port1Float > nodeData.max {
                    port2.value = nodeData.min
                } else if port1Float < nodeData.min {
                    port2.value = nodeData.max
                } else {
                    port2.value = port1Float
                }
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
    
    override class func getDefaultDataOutPorts() -> [NodeDataPortData] {
        return [
            CGFloatNodeDataPort(portID: 0, name: "Result", direction: .output)
        ]
    }
    
    var min : CGFloat = -100
    var max : CGFloat = 100
    
    override class func getDefaultCustomRendering(node: NodeData) -> AnyView? {
        AnyView (
            HStack {
                Text("Min")
                TextField("Min", value: .init(get: { () -> CGFloat in
                    if let node = node as? LoopFloatNode {
                        return node.min
                    } else { return CGFloat(0) }
                }, set: { newValue in
                    if let node = node as? LoopFloatNode {
                        node.min = newValue
                    }
                }), formatter: NumberFormatter(), prompt: Text("Min"))
                .textFieldStyle(.roundedBorder)
                
                Text("Max")
                TextField("Min", value: .init(get: { () -> CGFloat in
                    if let node = node as? LoopFloatNode {
                        return node.max
                    } else { return CGFloat(0) }
                }, set: { newValue in
                    if let node = node as? LoopFloatNode {
                        node.max = newValue
                    }
                }), formatter: NumberFormatter(), prompt: Text("Max"))
                .textFieldStyle(.roundedBorder)
            }
            .font(.caption.monospaced())
            .frame(minWidth: 140, maxWidth: 180, alignment: .center)
        )
    }
}
