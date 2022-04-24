//
//  TriggerNode.swift
//  ScriptNode
//
//  Created by fincher on 4/21/22.
//

import SwiftUI
import Foundation

class TriggerNode : NodeData {
    
    override class func getDefaultCategory() -> String {
        "Event"
    }
    
    class override func getDefaultTitle() -> String {
        "Trigger"
    }
    
    override class func getDefaultControlOutPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .output)
        ]
    }
    
    override class func getDefaultPerformImplementation() -> ((NodeData) -> ()) {
        return { nodeData in
            nodeData.outControlPorts[safe: 0]?.connections[safe: 0]?.endPort?.nodeData?.perform()
        }
    }
    
    override class func getDefaultCustomRendering(node: NodeData) -> AnyView? {
        AnyView(
            ZStack {
                Button {
                    if let node = node as? TriggerNode {
                        node.perform()
                    }
                } label: {
                    Text("Click To Trigger")
                        .font(.body.monospaced())
                }
                .buttonStyle(BorderedButtonStyle())
            }.frame(minWidth: 100, alignment: .center)
        )
    }
}
