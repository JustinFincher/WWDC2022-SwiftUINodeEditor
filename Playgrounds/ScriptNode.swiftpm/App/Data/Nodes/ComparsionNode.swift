//
//  ComparsionNode.swift
//  ScriptNode
//
//  Created by fincher on 4/24/22.
//

import Foundation
import SwiftUI


class ComparsionNode : NodeData {
    
    override class func getDefaultCategory() -> String {
        "Operator"
    }
    
    class override func getDefaultTitle() -> String {
        "Comparsion ⚖️"
    }
    
    override class func getDefaultControlOutPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: ">", direction: .output),
            NodeControlPortData(portID: 1, name: "=", direction: .output),
            NodeControlPortData(portID: 2, name: "<", direction: .output)
        ]
    }
    
    override class func getDefaultControlInPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .input)
        ]
    }
    
    override class func getDefaultDataInPorts() -> [NodeDataPortData] {
        return [
            CGFloatNodeDataPort(portID: 0, name: "Value", direction: .input)
        ]
    }
    
    
    override class func getDefaultPerformImplementation() -> ((NodeData) -> ()) {
        return {nodeData in
            if let nodeData = nodeData as? ComparsionNode,
               let inDataPort1 = nodeData.inDataPorts[safe: 0],
               let inDataPort1Value = inDataPort1.value as? CGFloat,
               let outControlPort1 = nodeData.outControlPorts[safe: 0],
               let outControlPort2 = nodeData.outControlPorts[safe: 1],
               let outControlPort3 = nodeData.outControlPorts[safe: 2]
            {
                if inDataPort1Value > nodeData.comparsionTo {
                    outControlPort1.connections[safe: 0]?.endPort?.nodeData?.perform()
                } else if inDataPort1Value == nodeData.comparsionTo {
                    outControlPort2.connections[safe: 0]?.endPort?.nodeData?.perform()
                }  else {
                    outControlPort3.connections[safe: 0]?.endPort?.nodeData?.perform()
                }
            }
        }
    }
    
    var comparsionTo : CGFloat = 0
    
    override class func getDefaultCustomRendering(node: NodeData) -> AnyView? {
        AnyView(
            VStack {
                Text("Comparing To:")
                    .font(.footnote.monospaced())
                HStack {
                    TextField("Compare To", value: .init(get: { () -> CGFloat in
                        if let node = node as? ComparsionNode {
                            return node.comparsionTo
                        } else { return CGFloat(0) }
                    }, set: { newValue in
                        if let node = node as? ComparsionNode {
                            node.comparsionTo = newValue
                        }
                    }), formatter: NumberFormatter(), prompt: Text("Compare To"))
                    .textFieldStyle(.roundedBorder)
                }
                .font(.caption.monospaced())
            }
            .frame(minWidth: 100, maxWidth: 180, alignment: .center)
        )
    }

}
