//
//  TriggerNode.swift
//  ScriptNode
//
//  Created by fincher on 4/21/22.
//

import SwiftUI
import Foundation

class TriggerNode : NodeData {
    
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
            let outPort : NodeControlPortData = nodeData.outControlPorts[0]
            guard let outPortConnection = outPort.connections.first,
                  let inPort : NodeControlPortData = outPortConnection.endPort as? NodeControlPortData else {
                return
            }
            
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
