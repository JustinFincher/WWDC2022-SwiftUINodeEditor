//
//  PrintNode.swift
//  ScriptNode
//
//  Created by fincher on 4/24/22.
//

import Foundation
import SpriteKit
import SwiftUI

class PrintNode : NodeData {
    
    override class func getDefaultCategory() -> String {
        "Operator"
    }
    
    class override func getDefaultTitle() -> String {
        "Print String 📝"
    }
    
    override class func getDefaultPerformImplementation() -> ((NodeData) -> ()) {
        return { nodeData in
            if let nodeData = nodeData as? PrintNode
            {
                print("\(nodeData.content)")
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
    
    
    var content : String = ""
    
    override class func getDefaultCustomRendering(node: NodeData) -> AnyView? {
        return AnyView (
            HStack {
                Text("Content")
                TextField("Content", text: .init(get: { () -> String in
                    if let node = node as? PrintNode {
                        return node.content
                    } else { return "" }
                }, set: { newValue in
                    if let node = node as? PrintNode {
                        node.content = newValue
                    }
                }),prompt: Text("Content"))
                .textFieldStyle(.roundedBorder)
            }
            .font(.caption.monospaced())
            .frame(minWidth: 120, maxWidth: 180, alignment: .center)
        )
    }
}
